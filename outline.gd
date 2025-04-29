extends Control

@export var line_color: Color = Color(0, 0, 0) 
@export var line_width: float = 3.0 

func _draw():
	var points = PackedVector2Array([
		Vector2(620, 500),  #bottomleft
		Vector2(680, 500),  #bottomright
		Vector2(692, 451),  #topright
		Vector2(635, 451)   #topleft
	])

	for i in range(points.size()):
		var start_point = points[i]
		var end_point = points[(i + 1) % points.size()]
		draw_line(start_point, end_point, line_color, line_width)
