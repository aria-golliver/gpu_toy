vec3 sliderColor = vec3(0, 122./255, 217./255);
vec3 barColor = vec3(160./255);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    fragColor = vec4(1);

    float mouseX = clamp((iMouse/iResolution).x, 0, 1);
    vec2 frag = fragCoord/iResolution;

    vec4 color;
    if(frag.x < mouseX) {
        color=texture(texture_sheet1, frag*vec2(1/mouseX, 1));
    } else {
        color = texture(texture_sheet2, (frag - vec2(mouseX, 0)) * vec2(1/(1-mouseX), 1));
    }

    fragColor = color;
}
