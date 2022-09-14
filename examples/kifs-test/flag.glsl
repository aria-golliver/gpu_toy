#define PI 3.1415923

#define BLUE (vec3(91., 206., 250.)/vec3(255.))
#define PINK (vec3(245., 169., 184.)/vec3(255.))
#define WHITE (vec3(255., 255., 255.)/vec3(255.))

float atan2(in float y, in float x)
{
    bool s = (abs(x) > abs(y));
    return mix(PI/2.0 - atan(x,y), atan(y,x), s);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv=fragCoord/iResolution;
    vec2 mouse = iMouse/iResolution;
    uv -= vec2(mouse.x, 1.-mouse.y);//vec2(.5, .5);
    uv *= 2.;
    vec3 col = vec3(0.);
    float a = atan2(uv.y, uv.x);
    float spin = iTime * .1;

    col += smoothstep(0., 3./3., abs(sin((a + spin)*4))) * PINK;
    col += smoothstep(0., 3./3., abs(sin((a + spin)*8+PI/2))) * BLUE;
    col /= max(max(col.x, col.y), col.z);

    fragColor.rgb = col;
}