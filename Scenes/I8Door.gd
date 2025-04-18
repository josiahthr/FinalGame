extends StaticBody3D


@export var dialogue_line: Array[String] = [
	"I should talk to jamian before I go"
]
@export var speaker_name: String = "Jamian" 
@export var jamian_node_path: NodePath
var has_jamian_talked = false
var dialogue_index := 0
func _ready():
	print("Door's jamian_node_path:", jamian_node_path)
	var jamian_node = get_node(jamian_node_path)
	if jamian_node:
		jamian_node.connect("jamian_talk", Callable(self, "_on_jamian_talked"))
	else:
		printerr("Error: Jamian node not found at path:", jamian_node_path)

func _on_jamian_talked():
	print("Door received the 'jamian_talk' signal!")
	has_jamian_talked = true

func interact():
	if has_jamian_talked == true:
		print("interacted with I8Door")
		get_tree().change_scene_to_file("res://Scenes/I9.tscn")
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
