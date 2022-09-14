#define PI 3.1415923

#define BLUE (vec3(91., 206., 250.)/vec3(255.))
#define PINK (vec3(245., 169., 184.)/vec3(255.))
#define WHITE (vec3(255., 255., 255.)/vec3(255.))

float atan2(in float y, in float x)
{
    return x == 0.0 ? sign(y)*PI/2 : atan(y, x);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv=fragCoord/iResolution;
    vec2 mouse = iMouse/iResolution;
    uv -= vec2(mouse.x, 1.-mouse.y);
    //uv -= vec2(.5, .5);
    uv *= 2.;
    vec3 col = vec3(0.);
    float l = length(uv);
    float a = atan2(uv.y, uv.x);
    float tightness = 15.;
    float direction = -1.;
    float spirals = direction*3.;
    uv = normalize(vec2(cos(a*spirals+sqrt(l*tightness)+iTime), sin(a*spirals+(l*tightness)+iTime)));
    a = atan2(uv.y, uv.x);


    if (a/PI < -1./3.)
        col = BLUE;
    else if (a/PI > 1./3.)
        col = PINK;
    else
        col = WHITE;
    
    fragColor.rgb=col;
}