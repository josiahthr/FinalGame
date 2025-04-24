extends StaticBody3D

var is_tilted: bool = false
@export var tilt_angle_degrees: float = -85.0
@onready var door :=  $".."


func interact():
	print("interacted with MidwichSign")
	if not is_tilted:
		door.rotation_degrees.y += tilt_angle_degrees
		is_tilted = true
	else:
		door.rotation_degrees.y -= tilt_angle_degrees
		is_tilted = false
