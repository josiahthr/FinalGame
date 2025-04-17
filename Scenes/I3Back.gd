extends StaticBody3D


@export var interaction_text: String = "I3Door"

func interact():
	print("interacted with I3Door")
	get_tree().change_scene_to_file("res://Scenes/I2.tscn")

func get_interaction_text():
	return interaction_text
