extends StaticBody3D

var is_tilted: bool = false
@export var tilt_angle_degrees: float = -85.0
@onready var door_open_sound: AudioStreamPlayer3D = $"../../../../../../DoorOpen"
@onready var door_close_sound: AudioStreamPlayer3D = $"../../../../../../DoorClose"
@export var tilt_duration: float = 2
@onready var door :=  $".."
var tween: Tween

func interact():
	print("interacted with NurseDoor")
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween()
	if not is_tilted:
		tween.tween_property(door, "rotation_degrees:y", tilt_angle_degrees, tilt_duration)
		door_open_sound.play()
		is_tilted = true
	else:
		tween.tween_property(door, "rotation_degrees:y", 0.0, tilt_duration)
		door_close_sound.play()
		is_tilted = false
