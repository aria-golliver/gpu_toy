#include "gpu_toy.h"

#include "shader_header.h"
#include "filesystem_include.h"
#include "live_reloading_shader.h"

#include <chrono>
#include <iostream>
#include <memory>
#include <string>
#include <thread>
#include <tuple>
#include <vector>

using namespace std::chrono_literals;

std::string get_watch_folder(std::vector<std::string>& args) {

    fs::path path;
    if (args.size() > 1) {
        path = fs::path{ args[1] };
    }
    else {
        std::cout << "Please enter the folder you wish to monitor:" << std::endl;
        std::string in;
        std::getline(std::cin, in);
        path = { in };
    }
    if (path.has_extension())
        path.remove_filename();

    return path.generic_string();
}

void reInit(std::vector<std::pair<fs::path, std::unique_ptr<LiveReloadingShader>>>& shaders, const std::string& projectDirectory) {
    bool reInitialized;
    do {
        reInitialized = true;
        std::vector<fs::path> currentFileset;
        for (const auto& shaderFile : fs::directory_iterator(projectDirectory)) {
            if (shaderFile.path().has_extension() && shaderFile.path().extension() == ".glsl")
                currentFileset.emplace_back(shaderFile.path());
        }

        if (currentFileset.size() != shaders.size()) {
            std::cout << "added or removed shaders, new size: " << currentFileset.size() << " old size: shaders.size()" << std::endl;
        }

        // see if any of the currently loaded shaders are no longer in the folder
        // and remove them
        for (auto shaderItr = shaders.begin(); shaderItr != shaders.end(); ) {
            bool found = false;
            for (const auto& currentFile : currentFileset) {
                if (currentFile.generic_string() == shaderItr->first.generic_string())
                    found = true;
            }
            if (!found)
                shaderItr = shaders.erase(shaderItr);
            else
                ++shaderItr;
        }

        // see if any of the current files are not loaded as shaders, and add them
        for (const auto& currentFile : currentFileset) {
            bool found = false;
            for (const auto& currentShader : shaders) {

                if (currentFile.generic_string() == currentShader.first.generic_string())
                    found = true;
            }
            if (!found)
                shaders.emplace_back(std::make_pair(currentFile, std::make_unique<LiveReloadingShader>(currentFile, shaders)));
        }

        for (const auto& shader : shaders) {
            shader.second->UpdatePreviousFrame();
        }

        for (const auto& shader : shaders) {
            if (!shader.second->UpdateShader()) {
                reInitialized = false;
                break;
            }
        }
    } while (!reInitialized);
}

void gpu_toy_main(std::vector<std::string> args) {
    auto projectDirectory = get_watch_folder(args);

    std::cout << "watching: " << projectDirectory << std::endl;

    std::vector<std::pair<fs::path, std::unique_ptr<LiveReloadingShader>>> shaders;
    reInit(shaders, projectDirectory);


    SimpleFileWatcher fw(projectDirectory);
    int i = 0;
    const int t = 100;
    using namespace std::chrono;
    time_point<steady_clock> tSamplesAgo = steady_clock::now();
    while (1) {
        if (++i % t == 0) {
            i = 0;
            auto now = steady_clock::now();
            std::cout << 1. / ((now - tSamplesAgo).count() * (1. / steady_clock::period::den) / (1. * t)) << std::endl;
            tSamplesAgo = now;
        }

        if (shaders.empty()) {
            std::this_thread::sleep_for(100ms);
        }

        for (const auto& shader : shaders) {
            shader.second->UpdatePreviousFrame();
        }

        if (fw.CheckChanged()) {
            reInit(shaders, projectDirectory);
        }

        for (const auto& shader : shaders) {
            shader.second->Tick();
            if (shader.second->windowClosed)
                return;
        }

        for (const auto& shader : shaders) {
            if (shader.second->gainedFocus)
            {
                for (const auto& shader : shaders) {
                    shader.second->RequestFocus();
                }
                for (const auto& shader : shaders) {
                    shader.second->gainedFocus = false;
                }
                break;
            }
        }
    }
}
