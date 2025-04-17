extends StaticBody3D

@export var interaction_text: String = "poster"
@export var dialogue_line: Array[String] = [
	"You know looking at this poster...",
	"It truly does remind me of humanity...",
	"And the fact that I can interact with E...",
	"And walk with the WASD keys."
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with Poster")
	
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
