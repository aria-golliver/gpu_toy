vec3 box00color = vec3(78, 121, 167) / 225.;
vec3 box01color = vec3(237, 201, 72) / 225.;
vec3 box10color = vec3(242, 142, 43) / 225.;
vec3 box11color = vec3(176, 122, 161) / 225.;
vec3 box20color = vec3(225, 87, 89) / 225.;
vec3 box21color = vec3(255, 157, 167) / 225.;
vec3 box30color = vec3(118, 183, 178) / 225.;
vec3 box31color = vec3(156, 117, 95) / 225.;
vec3 box40color = vec3(89, 161, 79) / 225.;
vec3 box41color = vec3(186, 176, 172) / 225.;

bool inBox(vec2 frag, vec2 start, float offset) {
	float size = .1;
	frag -= start;
	return frag.x > -offset && frag.y > -offset && frag.x < size+offset && frag.y < size+offset;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 frag = fragCoord/iResolution;
    vec2 mouse = iMouse/iResolution;

    if(fragCoord.x < 1 && fragCoord.y < 1){
    	fragColor = texture(texture_color_picker, frag);
    	if(fragColor.r == 0)
    	    fragColor = vec4(box00color,1);
    }
    else{
        fragColor = vec4(1);
    }

    // size of boxes
    float size = .1;
    float border = .005;

    // start of boxes
    vec2 box00 = vec2(.05,.85);
    vec2 box10 = vec2(.05,.85) + vec2(0, -size * 2);
    vec2 box20 = vec2(.05,.85) + vec2(0, -size * 4);
    vec2 box30 = vec2(.05,.85) + vec2(0, -size * 6);
    vec2 box40 = vec2(.05,.85) + vec2(0, -size * 8);
    vec2 box01 = vec2(.05,.85) + vec2(size*3, -size * 0);
    vec2 box11 = vec2(.05,.85) + vec2(size*3, -size * 2);
    vec2 box21 = vec2(.05,.85) + vec2(size*3, -size * 4);
    vec2 box31 = vec2(.05,.85) + vec2(size*3, -size * 6);
    vec2 box41 = vec2(.05,.85) + vec2(size*3, -size * 8);

    if(inBox(frag, box00,.005))
        fragColor = vec4(0);
    if(inBox(frag, box00, 0))
        fragColor = vec4(box00color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box00, 0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box00color, 1);

    if(inBox(frag, box10,.005))
        fragColor = vec4(0);
    if(inBox(frag, box10, 0))
        fragColor = vec4(box10color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box10, 0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box10color, 1);


    if(inBox(frag, box20,.005))
        fragColor = vec4(0);
    if(inBox(frag, box20,0))
        fragColor = vec4(box20color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box20,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box20color, 1);

    if(inBox(frag, box30,.005))
        fragColor = vec4(0);
    if(inBox(frag, box30,0))
        fragColor = vec4(box30color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box30,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box30color, 1);

    if(inBox(frag, box40,.005))
        fragColor = vec4(0);
    if(inBox(frag, box40,0))
        fragColor = vec4(box40color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box40,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box40color, 1);

    if(inBox(frag, box01,.005))
        fragColor = vec4(0);
    if(inBox(frag, box01,0))
        fragColor = vec4(box01color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box01,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box01color, 1);

    if(inBox(frag, box11,.005))
        fragColor = vec4(0);
    if(inBox(frag, box11,0))
        fragColor = vec4(box11color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box11,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box11color, 1);


    if(inBox(frag, box21,.005))
        fragColor = vec4(0);
    if(inBox(frag, box21,0))
        fragColor = vec4(box21color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box21,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box21color, 1);

    if(inBox(frag, box31,.005))
        fragColor = vec4(0);
    if(inBox(frag, box31,0))
        fragColor = vec4(box31color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box31,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box31color, 1);

    if(inBox(frag, box41,.005))
        fragColor = vec4(0);
    if(inBox(frag, box41,0))
        fragColor = vec4(box41color, 1);
    if(inBox(abs(vec2(0, 1) - mouse), box41,0) && fragCoord.x < 1 && fragCoord.y < 1)
        fragColor = vec4(box41color, 1);
}
