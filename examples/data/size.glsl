vec3 sliderColor = vec3(0, 122./255, 217./255);
vec3 barColor = vec3(160./255);

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    fragColor = vec4(1);

    float mouseX = clamp((iMouse/iResolution).x, 0, 1);
    vec2 frag = fragCoord/iResolution;

    if(fragCoord.x < 1 && fragCoord.y < 1) {
        fragColor = vec4(mouseX);
    }

    if(frag.y > .48)
        if(frag.y < .52)
            if(frag.x > 1./60)
                if(frag.x < 1 - 1./60)
                    fragColor = vec4(barColor, 1);

    if(frag.y > .45)
        if(frag.y < .55)
            if(frag.x > .5 - 1./300)
                if(frag.x < .5 + 1./300)
                    fragColor = vec4(barColor, 1);

    if(frag.x > mouseX - 1. / 40)
        if(frag.x < mouseX + 1. / 40)
            if(frag.y > .3 && frag.y < .7)
            fragColor = vec4(sliderColor, 1);
}
