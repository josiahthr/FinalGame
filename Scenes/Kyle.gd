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
var has_spoken_once = false

func interact():
	print("interacted with Kyle")
	if in_dialogue:
		in_dialogue = false
		printerr("in_dialogue is now false")
		has_spoken_once = false
		print("has_spoken_once is now false")
	else:
		in_dialogue = true
		print("in_dialogue is now true")
		emit_signal("Kyle_talk")
		has_spoken_once = true
		print("has_spoken_once is now true")
	
func get_dialogue_data():
	if in_dialogue and has_spoken_once:
		if dialogue_line.size() > 0:
			var random_index = randi() % dialogue_line.size()
			var line = dialogue_line[random_index]
			has_spoken_once = false
			print("has_spoken_once is now false")
			return {
				"text": line,
				"speaker": speaker_name
			}
	return null

func get_interaction_text():
	return interaction_text
	
func this_is_random():
	pass
