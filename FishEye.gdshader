shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5);
uniform float strength = 0.3;

void fragment() {
	vec2 uv = UV;

	vec2 offset = uv - center;
	float dist_sq = dot(offset, offset);
	float distortion = 1.0 + strength * dist_sq;

	uv = center + offset * distortion;
	uv = clamp(uv, vec2(0.0), vec2(1.0));


	COLOR = texture(TEXTURE, uv);
}
