extends StaticBody3D

@export var interaction_text: String = "DoorI11"
@onready var door_lock: AudioStreamPlayer = $"../../AudioStreamPlayer"
@export var dialogue_line: Array[String] = [
	"No I can't clock out yet"
]
@export var speaker_name: String = "Ian" 

var dialogue_index := 0

func interact():
	door_lock.play()
	print("interacted with DoorI11")
	
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
