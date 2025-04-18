extends StaticBody3D


@export var interaction_text: String = "I8Door"
@export var jamian_node_path: NodePath
var has_jamian_talked = false

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
		print("talk to jamian first")

func get_interaction_text():
	return interaction_text
