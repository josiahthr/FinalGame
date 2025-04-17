extends StaticBody3D

@export var interaction_text: String = "iancar"
@export var dialogue_line: Array[String] = [
	"Yeah I'm not starting",
	"not gonna happen",
	"no",
	"nuh uh"
]
@export var speaker_name: String = "Ian's Car" 

var dialogue_index := 0

func interact():
	print("interacted with Iancar")
	
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
