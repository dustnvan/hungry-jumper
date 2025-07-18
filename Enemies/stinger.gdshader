shader_type canvas_item;

uniform bool flash_stinger = false;
uniform vec4 flash_color = vec4(1.0, 1.0, 1.0, 1.0);
void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);

	if (flash_stinger)
	{
		COLOR = vec4(flash_color.rgb, tex_color.a);
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
