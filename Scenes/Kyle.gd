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

var in_dialogue = false
var dialogue_index := 0

func interact():
	print("interacted with Kyle")
	if in_dialogue:
		in_dialogue = false
	else:
		in_dialogue = true
		emit_signal("Kyle_talk")
	
func get_dialogue_data():
	if dialogue_line.size() > 0:
		var random_index = randi() % dialogue_line.size()
		var line = dialogue_line[random_index]
		return {
			"text": line,
			"speaker": speaker_name
		}
	return null

func get_interaction_text():
	return interaction_text
	
func this_is_kyle():
	pass
