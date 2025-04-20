extends StaticBody3D

@export var interaction_text: String = "Ian"
@export var dialogue_line: Array[String] = [
	"There's Rene again?"
]
@export var speaker_name: String = "Ian" 

var dialogue_index := 0

func interact():
	print("interacted with Rene2")
	
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
