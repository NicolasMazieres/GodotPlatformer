shader_type canvas_item;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 current_texture = texture(TEXTURE, UV);
	float current_alpha = current_texture.a; // Read from texture
	
	if (current_alpha <= 0.4){
		COLOR.a = 0.0;
	}
}

