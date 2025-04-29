extends Control

@export var line_color: Color = Color(0, 0, 0) 
@export var line_width: float = 3.0 

func _draw():
	var points = PackedVector2Array([
		Vector2(640, 562),  #bottomleft
		Vector2(700, 562),  #bottomright
		Vector2(712, 512),  #topright
		Vector2(655, 512.0)   #topleft
	])

	for i in range(points.size()):
		var start_point = points[i]
		var end_point = points[(i + 1) % points.size()]
		draw_line(start_point, end_point, line_color, line_width)
