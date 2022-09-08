#pragma once

#include <string>

#include "filesystem_include.h"


namespace {
    std::string shaderHeader = R"(\
#version 410

uniform vec2      iResolution;           // viewport resolution (in pixels)
uniform float     iTime;                 // shader playback time (in seconds)
uniform float     iTimeDelta;            // render time (in seconds)
//uniform int       iFrame;                // shader playback frame
//uniform float     iChannelTime[4];       // channel playback time (in seconds)
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
uniform vec2      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
//uniform vec4      iDate;                 // (year, month, day, time in seconds)
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)

void mainImage(out vec4 fragColor, in vec2 fragCoord);
void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}

vec2 _norm_pixel(vec2 fragCoord) {
    return fragCoord / iResolution;
}
#define norm_pixel _norm_pixel(fragCoord)

vec2 _norm_mouse() {
    return iMouse / iResolution * vec2(1, -1) + vec2(0, 1);
}
#define norm_mouse _norm_mouse()
)";
    std::string headerEnd = "//#####$$$$$ END HEADER $$$$$#####//\n";

    std::string shaderTemplate = R"(
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;

    // Time varying pixel color
    vec3 col = .5 + .5 * cos(iTime + uv.xyx + vec3(0, 2, 4));
    
    fragColor = vec4(col, 1.0);
}
)";
}

