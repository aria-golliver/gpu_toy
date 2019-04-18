float animate = 1;

vec3 sliderColor = vec3(0, 122./255, 217./255);
vec3 barColor = vec3(160./255);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    fragColor = vec4(1);

    float mouseX = clamp((iMouse/iResolution).x, 0, 1);
    vec2 frag = fragCoord/iResolution;
    vec3 color = texture(texture_color_picker, vec2(0,0)).rgb;
    float size = texture(texture_size, vec2(0,0)).x;

    float bars = 5;
    float barHeight = 1./bars;
    for(int i = 0; i < bars; ++i) {
        float x = abs(cos(i*5+3+animate*iTime/1*sin(1+i)));
        float y = i / bars + 1/bars/2.;
        if(frag.x < x) {
            if(frag.y > y - barHeight * size / 2 && frag.y < y + barHeight * size / 2) {
                fragColor = vec4(color, 1);
            }
        }
    }

    if(frag.x < .02)
    fragColor = vec4(.5);
    if(frag.x < .01)
    fragColor = vec4(1);
}
