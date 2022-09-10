shader_type canvas_item;

uniform bool is_white = false;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	
	if (is_white) {
		vec3 white = vec3(1, 1, 1);
		vec3 modulated_color = mix(texture_color.rgb, white, 0.6);
		
		COLOR = vec4(modulated_color, texture_color.a)
	} else {
		COLOR = texture_color;
	}
}