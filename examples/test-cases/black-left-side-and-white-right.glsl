#define PI 3.1415923

#define BLUE (vec3(91., 206., 250.)/vec3(255.))
#define PINK (vec3(245., 169., 184.)/vec3(255.))
#define WHITE (vec3(255., 255., 255.)/vec3(255.))

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    if (fragCoord.x > iResolution.x/2) {
        fragColor = vec4(1.);
    } else {
        fragColor = vec4(0.);
    }
}