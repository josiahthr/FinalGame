extends StaticBody3D

@export var interaction_text: String = "SchoolMap"
@export var dialogue_line: Array[String] = [
	"There is a [color=#30bf2e]School Map[/color].
	[left]         Take it?[/left]"
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with SchoolMap")
	
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
