void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    fragColor = vec4(texture2D(texture_quaternion, abs(vec2(0,0)-fragCoord/iResolution)).rgb, 1);
}
