extends StaticBody3D


@export var interaction_text: String = "I7Door"

func interact():
	print("interacted with I7Door")
	get_tree().change_scene_to_file("res://Scenes/I8.tscn")

func get_interaction_text():
	return interaction_text
