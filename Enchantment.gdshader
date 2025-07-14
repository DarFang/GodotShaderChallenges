shader_type canvas_item;

uniform vec4 tint_color : source_color = vec4(0.2, 0.5, 1.0, .5);
uniform float tint_pct : hint_range(0.0, 1.0);
uniform float tint_freq : hint_range(0.0, 5.0); // breathing speed
uniform float tint_amp : hint_range(0.0, 1.0);  // how much the tint strength pulses

uniform vec4 glint_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float glint_width = 0.1;
uniform float glint_speed = 1.0;
uniform float frequency = 0.5;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);
    float breathe = sin(TIME * tint_freq); // 2*PI
    breathe = breathe * 0.5 + 0.5;

    float tint_strength = tint_pct + breathe * tint_amp;

    tint_strength = clamp(tint_strength, 0.0, 1.0);

    vec4 tinted_color = mix(original_color, tint_color, tint_strength);

    float glint_pos = fract((UV.x + UV.y) * frequency + TIME * glint_speed);
    float mask = smoothstep(0.0, glint_width, glint_pos) * smoothstep(1.0, 1.0 - glint_width, glint_pos);
    mask = 1.0 - mask;

    vec4 final_color = tinted_color + glint_color * mask;

    final_color = clamp(final_color, 0.0, 1.0);
    final_color.a *= original_color.a;

    COLOR = final_color;
}
