extends StaticBody3D


@onready var I8Door: MeshInstance3D = $"../../../MeshInstance3D14"

@export var speaker_name: String = "Ian's Car" 
@export var interaction_text: String = "IansCar"
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
var has_spoken_once = false

func interact():
	print("interacted with IansCar")
	I8Door.show()
	if in_dialogue:
		in_dialogue = false
		has_spoken_once = false
	else:
		in_dialogue = true
		has_spoken_once = true
	
func get_dialogue_data():
	if in_dialogue and has_spoken_once:
		if dialogue_line.size() > 0:
			var random_index = randi() % dialogue_line.size()
			var line = dialogue_line[random_index]
			# Immediately set has_spoken_once to false after providing the line
			has_spoken_once = false
			return {
				"text": line,
				"speaker": speaker_name
			}
	return null

func get_interaction_text():
	return interaction_text
	
func this_is_random():
	pass
