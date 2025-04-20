extends StaticBody3D

signal Kyle_talk

@onready var I8Door: MeshInstance3D = $"../../MeshInstance3D11"

@export var speaker_name: String = "Ian's Car" 

@export var interaction_text: String = "IanCar"
@export var dialogue_line: Array[String] = [
	"nah man",
	"yeah thats not happening",
	"should probably just take the shuttle",
	"cmon man I literally ran yesterday",
	"PLEASE JUST TAKE THE SHUTTLE",
	"I think the shifters broken",
	"Someone put 3 nails in my tire"
]

var in_dialogue = false
var dialogue_index := 0

func interact():
	print("interacted with Ian's car")
	if in_dialogue:
		in_dialogue = false
	else:
		in_dialogue = true
	
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
	
func this_is_random():
	pass
