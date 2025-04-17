extends StaticBody3D


@export var interaction_text: String = "I6Door"

func interact():
	print("interacted with I6Door")
	get_tree().change_scene_to_file("res://Scenes/I7.tscn")

func get_interaction_text():
	return interaction_text
