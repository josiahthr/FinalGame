extends StaticBody3D


@onready var I8Door: MeshInstance3D = $"../../MeshInstance3D11"

@export var interaction_text: String = "Wayne"
@export var dialogue_line: Array[String] = [
		"Remember [wave]Ian[/wave] if you forget how to be human...", 
		"you can always inspect your poster...",
		"using the E button",

]
@export var speaker_name: String = "Wayne" 

var dialogue_index := 0

func interact():
	print("interacted with Wayne")
	
	
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
