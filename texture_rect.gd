extends TextureRect

shader_type canvas_item;

uniform float slant_amount = 0.0; // Controls the horizontal slant

void fragment() {
	// Get the UV coordinates
	vec2 uv = UV;

	// Calculate the slanting factor based on the y-coordinate
	float slant_factor = slant_amount * uv.y;

	// Apply the slant to the x-coordinate of the UV
	uv.x += slant_factor;

	// Sample the texture with the modified UV coordinates
	COLOR = texture(TEXTURE, uv);
}
