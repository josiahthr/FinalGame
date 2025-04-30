extends StaticBody3D

@export var interaction_text: String = "CourtyardDoor"
@onready var text := $"../../../../../../CanvasLayer/Dialog/VBoxContainer/Dialogue"
@export var tilt_angle_degrees: float = -85.0
@onready var door_open_sound: AudioStreamPlayer3D = $"../../../../../../DoorOpen"
@onready var door_lock: AudioStreamPlayer3D = $"../../../../../../DoorLock"
@onready var door :=  $".."
@export var tilt_duration: float = 2
@export var has_key: = false
var tween: Tween
@export var dialogue_line: Array[String] = [
	"
	
	
	
	
	
	
	
	
	
	
	
	
	
	It's locked.",
		"
	
	
	
	
	
	
	
	
	
	
	
	
	But it looks like it 
	can be opened with a [color=#2ffd4f]key[/color]."
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	if has_key == false:
		print("interacted with CourtyardDoor")
		text.show()
		door_lock.play()
	elif has_key == true:
		tween = create_tween()
		tween.tween_property(door, "rotation_degrees:y", tilt_angle_degrees, tilt_duration)
		door_open_sound.play()
	
func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
			"text": line,
			"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		return null

func get_interaction_text():
	return interaction_text


func set_has_key(value: bool) -> void:
	has_key = value
