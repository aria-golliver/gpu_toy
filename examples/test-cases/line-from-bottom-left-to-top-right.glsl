void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    float d = abs(fragCoord.x - fragCoord.y);
    float wid = 50.;
    if(d < wid)  {
        fragColor = vec4(1.-d/wid);
    } else {
        fragColor = vec4(0.);
    }
}