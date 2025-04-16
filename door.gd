extends StaticBody3D


@export var interaction_text: String = "I3DoorForward"

func interact():
	print("interacted with I3DoorForward")
	get_tree().change_scene_to_file("res://I4.tscn")

func get_interaction_text():
	return interaction_text
