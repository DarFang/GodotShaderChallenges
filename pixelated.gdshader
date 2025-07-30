shader_type canvas_item;

uniform float pixel_scale :hint_range(0.0, 1.0, 0.005);

void fragment() {
    vec2 pixelResolution = (vec2(1.0) / SCREEN_PIXEL_SIZE) * pixel_scale; // resolution scale factor
    vec2 pixelatedUV = floor(UV * pixelResolution) / pixelResolution; // pixelize grid
    vec4 sampledColor = texture(TEXTURE, pixelatedUV);
    float luminance = dot(sampledColor.rgb, vec3(0.299, 0.587, 0.114));
    COLOR.rgb = vec3(luminance);
}
