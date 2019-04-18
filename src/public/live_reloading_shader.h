#pragma once

#include <string>
#include <memory>
#include "file_watcher.h"
#include <vector>
#include <SFML/Graphics.hpp>

#include "filesystem_include.h"

namespace sf { class RenderWindow; }

class LiveReloadingShader {
public:
    LiveReloadingShader(const fs::path& path, std::vector<std::pair<fs::path, std::unique_ptr<LiveReloadingShader>>>& shaders);
    ~LiveReloadingShader();

    std::string GetTextureName() const;
    const sf::Texture& GetPreviousFrameTexture() const;
    void UpdatePreviousFrame();
    void UpdateShader();

    void Tick();

    bool gainedFocus = false;
    void RequestFocus();

private:
    const fs::path shaderPath;
    const std::unique_ptr<sf::RenderWindow> window;
    SimpleFileWatcher fw;

    sf::Shader shader;
    sf::RenderTexture currentFrame;
    sf::RenderTexture previousFrame;
    sf::Vector2f mousePos;
    sf::Vector2f size;

    bool mouseEnabled;

    std::vector<std::pair<fs::path, std::unique_ptr<LiveReloadingShader>>>& shaders;
    std::string textureHeaders;

    std::chrono::steady_clock::time_point lastT;
    std::chrono::steady_clock::time_point lastGainedFocus = std::chrono::steady_clock::now();

public:
    bool windowClosed;
};
