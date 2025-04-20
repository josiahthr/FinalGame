extends StaticBody3D


@export var dialogue_line: Array[String] = [
	"Maybe I should ask [wave]Kyle[/wave] for a ride first"
]
@export var speaker_name: String = "Ian" 
@export var Kyle_node_path: NodePath
var has_Kyle_talked = false
var dialogue_index := 0
func _ready():
	print("Door's Kyle_node_path:", Kyle_node_path)
	var Kyle_node = get_node(Kyle_node_path)
	if Kyle_node:
		Kyle_node.connect("Kyle_talk", Callable(self, "_on_Kyle_talked"))
	else:
		printerr("Error: Kyle node not found at path:", Kyle_node_path)

func _on_Kyle_talked():
	print("Door received the 'Kyle_talk' signal!")
	has_Kyle_talked = true

func interact():
	if has_Kyle_talked == true:
		print("interacted with Highway")
		get_tree().change_scene_to_file("res://Scenes/I10.tscn")
	else:
		pass


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
