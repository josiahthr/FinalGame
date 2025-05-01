extends StaticBody3D

@export var interaction_text: String = "LeftHallDoor"
@onready var text := $"../../../../../../CanvasLayer/Dialog/VBoxContainer/Dialogue"
@onready var door_lock: AudioStreamPlayer3D = $"../../../../../../DoorLock"
@export var dialogue_line: Array[String] = [
	"
	
	
	
	
	
	
	
	
	
	
	
	
	
	It's locked."
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with LeftHallDoor")
	text.show()
	if dialogue_index == 0:
		door_lock.play()
	
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
