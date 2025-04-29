extends Control

func _draw():
	var start_point = Vector2(6, 9)

	var side1_length = 50
	var side2_length = 30

	var angle_deg = -70
	var angle_rad = deg_to_rad(angle_deg)


	var point1 = start_point + Vector2(side1_length, 0)
	var point2 = point1 + Vector2(side2_length * cos(angle_rad), side2_length * sin(angle_rad))
	var point3 = start_point + Vector2(side2_length * cos(angle_rad), side2_length * sin(angle_rad))


	var color = Color(0,0,254,255)
	
	var outline_color = Color(0, 0, 0)
	var outline_thickness = 2.0

	draw_line(start_point, point1, color, 2.0)
	draw_line(point1, point2, color, 2.0)
	draw_line(point2, point3, color, 2.0)
	draw_line(point3, start_point, color, 2.0)
	
	var points = PackedVector2Array([start_point, point1, point2, point3])
	
	draw_polygon(points, [color])
	
	draw_line(start_point, point1, outline_color, outline_thickness)
	draw_line(point1, point2, outline_color, outline_thickness)
	draw_line(point2, point3, outline_color, outline_thickness)
	draw_line(point3, start_point, outline_color, outline_thickness)
