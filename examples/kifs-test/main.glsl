
vec2 N(float angle) {
    return vec2(sin(angle), cos(angle));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (fragCoord-.5*iResolution.xy)/iResolution.y;
    vec2 mouse = iMouse.xy/iResolution.xy;
    vec3 col = vec3(0);
    uv.x = abs(uv.x);
    uv.y -= 1./6;
    uv *= 2;

    vec2 n = N(5./6.*3.141592);
    uv -= n*max(0., dot(uv-vec2(0.5, 0), n))*2.;

    n = N(2./3.*3.141592);
    float scale = 1;
    uv.x += 0.5;
    for(int i = 0; i < 50; i++) {
        uv *= 3;
        scale *= 3;
        uv.x -= 1.5;

        uv.x = abs(uv.x);
        uv.x -= 0.5;
        uv -= n*min(0., dot(uv, n))*2.;
    }

    float d = length(uv - vec2(clamp(uv.x, -1, 1), 0));
    
    //col += smoothstep(1./iResolution.y, 0., d/scale);
    uv /= scale;
    col.rgb += texture(texture_quaternion, uv).rgb;

    fragColor = vec4(col, 1.0);
}
