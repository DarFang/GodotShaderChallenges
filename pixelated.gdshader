shader_type canvas_item;

uniform float pixel_scale :hint_range(1.0, 100.0, 1.);

void fragment() {
    vec2 pixelResolution = (vec2(1.0) / SCREEN_PIXEL_SIZE) / pixel_scale; // resolution scale factor
    vec2 pixelatedUV = floor(UV * pixelResolution) / pixelResolution; // pixelize grid
    vec4 sampledColor = texture(TEXTURE, pixelatedUV);
    COLOR.rgb = sampledColor.rgb;
}
