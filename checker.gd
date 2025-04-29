extends Control

@export var checker_texture: Texture2D

func _draw():
	# Define the starting point.
	var start_point = Vector2(6, 10)
	var side1_length = 100
	var side2_length = 60
	var angle_deg = -70
	var angle_rad = deg_to_rad(angle_deg)

	# Calculate the points.
	var point1 = start_point + Vector2(side1_length, 0)
	var point2 = point1 + Vector2(side2_length * cos(angle_rad), side2_length * sin(angle_rad))
	var point3 = start_point + Vector2(side2_length * cos(angle_rad), side2_length * sin(angle_rad))
	var points = PackedVector2Array([start_point, point1, point2, point3])

	# Create a new ShaderMaterial.
	var shader_material = ShaderMaterial.new()

	# Load the shader.  Now uses a texture
	shader_material.shader = Shader.new()
	shader_material.shader.code = """
		shader_type canvas_item;
		uniform sampler2D checker_texture;

		void fragment() {
			// Calculate UV coordinates for the checkerboard.
			vec2 uv = (FRAGCOORD.xy / viewport_size);
			uv *= 10.0; // Adjust for the size of the checkers

			// Use floor to create the checkerboard pattern.
			int x = int(floor(uv.x));
			int y = int(floor(uv.y));
			
			 // Alternate colors based on the texture.
			if ((x + y) % 2 == 0) {
				COLOR = texture(checker_texture, uv);
			} else {
			   COLOR = texture(checker_texture, uv);
			}
		}
	"""
	# Set the texture in the ShaderMaterial
	shader_material.set_shader_parameter("checker_texture", checker_texture)

	# Draw the polygon with the shader material
	draw_polygon(points, PackedColorArray([Color(1,1,1)]), PackedVector2Array(), shader_material);

	# Draw outline
	var outline_color = Color(0,0,0)
	var outline_thickness = 2.0
	draw_line(start_point, point1, outline_color, outline_thickness)
	draw_line(point1, point2, outline_color, outline_thickness)
	draw_line(point2, point3, outline_color, outline_thickness)
	draw_line(point3, start_point, outline_color, outline_thickness)
