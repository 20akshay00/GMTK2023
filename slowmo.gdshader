shader_type canvas_item;
uniform vec2 pos;
uniform float radius;
uniform float fade;
uniform float aspect_ratio;
uniform float blur;

float CircleSDF(vec2 uv, vec2 centre)
{
	return length(uv - centre);
}

void fragment() {
//	COLOR = vec4(0., 0., 0., 0.5);
	vec2 uv = 2. * UV - 1.;
	uv.y *= aspect_ratio;
	float c = smoothstep(radius, radius + blur, CircleSDF(uv, vec2(0., 0.)));
	COLOR = vec4(0., 0., 0., c - fade);
}
