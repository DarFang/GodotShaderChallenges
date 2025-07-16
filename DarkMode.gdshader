shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform bool dark_mode = true;

// Convert RGB → HSV
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float h = abs(q.z + (q.w - q.y) / (6.0 * d + 1e-10));
    float s = d / (q.x + 1e-10);
    return vec3(h, s, q.x);
}

// Convert HSV → RGB
vec3 hsv2rgb(vec3 c) {
    vec3 p = abs(fract(c.xxx + vec3(0.0, 2.0/3.0, 1.0/3.0)) * 6.0 - 3.0);
    return c.z * mix(vec3(1.0), clamp(p - 1.0, 0.0, 1.0), c.y);
}

void fragment() {
    vec4 sc = texture(SCREEN_TEXTURE, SCREEN_UV);
    vec3 col = sc.rgb;

    if (dark_mode) {
        vec3 hsv = rgb2hsv(col);
        hsv.z = 1.0 - hsv.z;  
        col = hsv2rgb(hsv);
    }

    COLOR = vec4(col, sc.a);
}
