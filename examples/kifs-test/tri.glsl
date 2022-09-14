#define PI 3.1415923

#define BLUE (vec3(91., 206., 250.)/vec3(255.))
#define PINK (vec3(245., 169., 184.)/vec3(255.))
#define WHITE (vec3(255., 255., 255.)/vec3(255.))

float atan2(in float y, in float x)
{
    return x == 0.0 ? sign(y)*PI/2 : atan(y, x);
}

float _max(vec3 v) {
    return max(v.x, max(v.y, v.z));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv=fragCoord/iResolution;
    vec2 mouse = iMouse/iResolution;
    vec3 col = vec3(0.);

    uv -= .5;
    uv *= 2.;
    uv = abs(uv);

    col.rgb+=texture(texture_t, vec2(smoothstep(0.,1.,uv.x), smoothstep(0.,1.,uv.y))).rgb;
    fragColor.rgb=col;
}