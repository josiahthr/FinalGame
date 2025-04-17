extends StaticBody3D

@export var interaction_text: String = "Mattress"
@export var dialogue_line: Array[String] = [
	"mattress1.",
	"mattress2.",
	"mattress3."
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with Mattress")
	
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
