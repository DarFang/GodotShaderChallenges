shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform bool dark_mode;
uniform float desaturation: hint_range(0.0, 1.0, 0.1);

void fragment() {

		vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
		float gray = dot(screen_color.rgb, vec3(0.299, 0.587, 0.114));
		//ITU-R BT.601 standard for converting RGB to luminance for standard-definition TV signals.
    	vec3 desaturated = mix(screen_color.rgb, vec3(gray), desaturation);
		COLOR.rgb = desaturated;
	
    if(dark_mode)
	{
		COLOR.rgb = vec3(1.) - COLOR.rgb;
	}
	
}
