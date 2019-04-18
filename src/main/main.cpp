#include "gpu_toy.h"

int main(int argc, char** argv) {
    std::vector<std::string> args;
    for (int i = 0; i < argc; ++i) {
        args.emplace_back(argv[i]);
    }

    gpu_toy_main(std::move(args));

    return EXIT_SUCCESS;
}
