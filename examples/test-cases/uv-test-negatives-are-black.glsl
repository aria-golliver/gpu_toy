void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv=fragCoord/iResolution;
    uv *= 2.;
    uv -= 1.;
    fragColor.rg = uv;
}