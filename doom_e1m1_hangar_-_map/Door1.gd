extends StaticBody3D

var is_tilted: bool = false
@export var tilt_angle_degrees: float = 3.0
@export var tilt_duration: float = 2
@onready var door :=  $".."
@onready var dooropen :=  $"../DoorOpen"
@onready var doorclose :=  $"../DoorClose"
var tween: Tween

func interact():
	print("interacted with Door1")
	if tween and tween.is_running():
		tween.kill()

	tween = create_tween()
	if not is_tilted:
		dooropen.play()
		tween.tween_property(door, "rotation_degrees:y", tilt_angle_degrees, tilt_duration)
		is_tilted = true
		await get_tree().create_timer(5).timeout
		tween = create_tween()
		doorclose.play()
		tween.tween_property(door, "rotation_degrees:y", 0.0, tilt_duration)
		is_tilted = false
