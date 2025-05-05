extends Node2D

@export var max_rpm: float = 8000.0
@export var min_rotation_deg: float = 0.0
@export var max_rotation_deg: float = 102.0
@onready var car = get_parent()

func _process(delta):
	if not car:
		return
	var rpm = car.current_rpm
	var ratio = clamp(rpm / max_rpm, 0.0, 1.0)
	rotation_degrees = lerp(min_rotation_deg, max_rotation_deg, ratio)
