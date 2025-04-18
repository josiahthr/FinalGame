extends StaticBody3D


@export var interaction_text: String = "Highway"
@export var Kyle_node_path: NodePath
var has_Kyle_talked = false

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
		print("interacted with I8Door")
		get_tree().change_scene_to_file("res://Scenes/I10.tscn")
	else:
		print("talk to Kyle first")

func get_interaction_text():
	return interaction_text
