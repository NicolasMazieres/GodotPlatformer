shader_type canvas_item;

uniform vec3 color: source_color = vec3(1);
uniform float progress: hint_range(0.0, 1.0, 0.1) =0.0;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 current_texture = texture(TEXTURE, UV);
	float current_alpha = current_texture.a; // Read from texture
  	vec4 target_color = mix(current_texture, vec4(color, current_alpha), progress);
	COLOR = target_color;
}

