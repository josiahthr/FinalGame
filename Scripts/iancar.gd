extends StaticBody3D

@onready var ShowDoor: MeshInstance3D = $"../../../MeshInstance3D14"

@export var interaction_text: String = "iancar"
@export var dialogue_line: Array[String] = [
	"nah man",
	"yeah thats not happening",
	"should probably just take the shuttle",
	"cmon man I literally ran yesterday",
	"PLEASE JUST TAKE THE SHUTTLE",
	"I think the shifters broken",
	"Someone put 3 nails in my tire"
]
@export var speaker_name: String = "Ian's Car" 

var dialogue_index := 0

func interact():
	ShowDoor.show()
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
