vec3 sliderColor = vec3(0, 122./255, 217./255);
vec3 barColor = vec3(160./255);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    fragColor = vec4(1);

    float mouseX = clamp((iMouse/iResolution).x, 0, 1);
    vec2 frag = fragCoord/iResolution;
    vec3 color = texture(texture_color_picker, vec2(0,0)).rgb;
    float size = texture(texture_size, vec2(0,0)).x;

    #define points 100
    #define PI 3.141590

    for(int i = 0; i < points; ++i) {
        float posX = abs(sin(i*1514+7));
        float posY = abs(sin(i*6554+5));
        vec2 pos = vec2(posX, posY);
        vec2 dist = frag - pos;
        float d = sqrt(dist.x * dist.x + dist.y * dist.y);
        if(d < size/10)
        fragColor = vec4(color, 1);
    }

    if(frag.x < .02)
    fragColor = vec4(.5);
    if(frag.y < .02)
    fragColor = vec4(.5);
    if(frag.x < .01)
    fragColor = vec4(1);
    if(frag.y < .01)
    fragColor = vec4(1);

}
