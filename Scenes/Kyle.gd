extends StaticBody3D

signal Kyle_talk

@onready var I8Door: MeshInstance3D = $"../../MeshInstance3D11"

@export var speaker_name: String = "Kyle" 

@export var interaction_text: String = "Kyle"
@export var dialogue_line: Array[String] = [
	"no space",
	"I dont have a car",
	"Im going the other way",
	"I just don't really want to",
	"Think of the gas prices",
	"Get away from me",
	"Its a one seater",
	"Just walk to work"
]


var dialogue_index := 0

func interact():
	print("interacted with Kyle")
	emit_signal("Kyle_talk")
	
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
