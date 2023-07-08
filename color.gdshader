shader_type canvas_item;

void fragment() {
	float def_alpha = texture(TEXTURE, UV).a;
	COLOR = mix(texture(TEXTURE, UV), vec4(vec3(1, 0, 0), def_alpha), 0.2);
}
