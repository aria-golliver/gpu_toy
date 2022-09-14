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
    uv -= vec2(mouse.x, 1.-mouse.y);
    //uv -= vec2(.5, .5);
    uv *= 2.;
    vec3 col = WHITE;
    float l = length(uv);
    uv = vec2(cos(-l), sin(-l));

    float a = atan2(uv.y, uv.x);
    float spin = iTime * .1;

    float forks=5.;
    float pink = length(smoothstep(0., 3.33, abs(sin((a + spin)*2.*pow(2., forks)+PI/2))));
    float blue = length(smoothstep(0., 2.2, abs(sin((a + spin)*pow(2., forks)))));
    
    if (pink < .1)
        col = PINK;
    if (blue < .1)
        col = BLUE;

    fragColor.rgb = col;
}