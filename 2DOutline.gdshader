shader_type canvas_item;

uniform vec4 outline_color : source_color= vec4(1.0, 1.0, 1.0, 1.0);
uniform float outline_thickness : hint_range(0.0, 10.0) = 1.0;
uniform float threshold : hint_range(0.0, 1.0) = .1;
uniform bool toggle = false; 
uniform float size_muliplier : hint_range(1.0, 2.0) = 1.1;

void fragment() {
	if (toggle)
	{
	    vec4 tex = texture(TEXTURE, UV);
		
	    if (tex.a <= threshold) {
	        for (float x = -1.0; x <= 1.0; x += 1.0) {
	            for (float y = -1.0; y <= 1.0; y += 1.0) {
	                if (x == 0.0 && y == 0.0) continue;

	                vec2 offset = vec2(x, y) * outline_thickness * TEXTURE_PIXEL_SIZE;
	                float neighbor_alpha = texture(TEXTURE, UV + offset).a;

	                if (neighbor_alpha > threshold) {
	                    COLOR = outline_color;
	                    break;
	                }
	            }
	        }
	    }
	}
}
void vertex(){
	if(toggle)
	{
		VERTEX.xy *= size_muliplier;
	}
}
