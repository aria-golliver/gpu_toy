#pragma once

#include <string>
#include <vector>
#include <tuple>
#include <memory>
#include "live_reloading_shader.h"

#if !_HAS_CXX17 || !defined(_WIN32)
#include <experimental/filesystem>
namespace fs = std::experimental::filesystem;
#else
#include <filesystem>
namespace fs = std::filesystem;
#endif


namespace {
    std::string shaderHeader = "#version 450\n\
\n\
uniform vec2      iResolution;           // viewport resolution (in pixels)\n\
uniform float     iTime;                 // shader playback time (in seconds)\n\
uniform float     iTimeDelta;            // render time (in seconds)\n\
//uniform int       iFrame;                // shader playback frame\n\
//uniform float     iChannelTime[4];       // channel playback time (in seconds)\n\
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)\n\
uniform vec2      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click\n\
//uniform vec4      iDate;                 // (year, month, day, time in seconds)\n\
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)\n\
\n\
void mainImage(out vec4 fragColor, in vec2 fragCoord);\n\
void main() {\n\
    mainImage(gl_FragColor, gl_FragCoord.xy);\n\
}\n\
";
    std::string headerEnd = "//#####$$$$$ END HEADER $$$$$#####//\n";

}

