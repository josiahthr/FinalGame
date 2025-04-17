extends StaticBody3D


@export var interaction_text: String = "I3"

func interact():
	print("interacted with I3")
	get_tree().change_scene_to_file("res://I1.tscn")

func get_interaction_text():
	return interaction_text
