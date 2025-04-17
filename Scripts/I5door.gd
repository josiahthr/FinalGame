extends StaticBody3D


@export var interaction_text: String = "I5DoorForward"

func interact():
	print("interacted with I6DoorForward")
	get_tree().change_scene_to_file("res://Scenes/I6.tscn")

func get_interaction_text():
	return interaction_text
