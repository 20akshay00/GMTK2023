shader_type canvas_item;

uniform float mix_value = 0.;

void fragment() {
	float def_alpha = texture(TEXTURE, UV).a;
	COLOR = mix(texture(TEXTURE, UV), vec4(1., 1., 1., def_alpha), mix_value);
}
