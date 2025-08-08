shader_type canvas_item;

uniform sampler2D ascii_texture;
uniform float pixel_scale : hint_range(1.0, 100.0, 1.0);
uniform float _char_count = 10.0;
uniform bool use_hue = false;
uniform bool use_sqrt = false;

vec3 hsv2rgb(vec3 c) {
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    rgb = rgb * rgb * (3.0 - 2.0 * rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

float rgb2hue(vec3 c) {
    float maxc = max(max(c.r, c.g), c.b);
    float minc = min(min(c.r, c.g), c.b);
    float delta = maxc - minc;
    if (delta < 1e-5) return 0.0;
    if (maxc == c.r) return mod((c.g - c.b) / delta, 6.0) / 6.0;
    if (maxc == c.g) return (((c.b - c.r) / delta) + 2.0) / 6.0;
    return (((c.r - c.g) / delta) + 4.0) / 6.0;
}

float is_black(vec3 c) {
    return step(length(c), 0.001); // 1.0 if black
}

float is_white(vec3 c) {
    return step(length(c - vec3(1.0)), 0.001); // 1.0 if white
}

void fragment() {
    // Step 1: Pixelate the texture
    vec2 screen_pixel_res = vec2(1.0) / SCREEN_PIXEL_SIZE;
    vec2 pixel_grid = screen_pixel_res / pixel_scale;
    vec2 pixelated_uv = floor(UV * pixel_grid) / pixel_grid;
    vec4 sampled_color = texture(TEXTURE, pixelated_uv);
    
    // Step 2: Luminance → ASCII index
    float lum = dot(sampled_color.rgb, vec3(0.299, 0.587, 0.114));
	if (use_sqrt){
    	lum = sqrt(lum);
	}
    float index = floor(lum * (_char_count - 1.0));

    // Step 3: Intra-cell UV
    vec2 block_uv = fract(UV * pixel_grid);
    float char_u = index / _char_count;
    float char_w = 1.0 / _char_count;
    vec2 ascii_uv = vec2(char_u + block_uv.x * char_w, block_uv.y);

    // Step 4: Sample ASCII glyph
    float mask = texture(ascii_texture, ascii_uv).r;

    // Step 5: Determine color
    float black = is_black(sampled_color.rgb);
    float white = is_white(sampled_color.rgb);
    
    vec3 final_color = sampled_color.rgb;

    if (white > 0.5) {
        final_color = vec3(1.0);
    } else if (black > 0.5) {
        final_color = vec3(0.0);
    } else if (use_hue) {
        float hue = rgb2hue(sampled_color.rgb);
        final_color = hsv2rgb(vec3(hue, 1.0, 1.0));
    }

    COLOR = vec4(final_color * mask, 1.0);
}
