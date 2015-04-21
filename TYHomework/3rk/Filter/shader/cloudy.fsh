precision lowp float;
varying highp vec2 textureCoordinate;

uniform sampler2D videoFrame;
uniform sampler2D light;
uniform sampler2D channel_cloudy;
uniform sampler2D dark;

mat4 saturateMatrix = mat4(
                           0.516,0.216,0.216,0.0,
                           0.426,0.726,0.426,0.0,
                           0.057,0.057,0.357,0.0,
                           0.0,0.0,0.0,1.0);
void main() {	
   vec4 pic1;
    if (isBlur == 0) {pic1 = texture2D(videoFrame, textureCoordinate);}
    else { pic1 = GC_blur();}
    vec3 pic2 = texture2D(light, textureCoordinate).rgb;
    pic1 = saturateMatrix * pic1;
    pic1.r = texture2D(dark, vec2(pic2.r, pic1.r)).r;
    pic1.g = texture2D(dark, vec2(pic2.g, pic1.g)).g;
    pic1.b = texture2D(dark, vec2(pic2.b, pic1.b)).b;
    vec4 pic0;
    pic0.r = texture2D(channel_cloudy, vec2(pic1.r, 0.0)).r;
    pic0.g = texture2D(channel_cloudy, vec2(pic1.g, 0.5)).g;
    pic0.b = texture2D(channel_cloudy, vec2(pic1.b, 1.0)).b;
    pic0.a = 1.0;
    gl_FragColor = pic0;
}