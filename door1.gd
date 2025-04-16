extends StaticBody3D


@export var interaction_text: String = "Door"

func interact():
	print("interacted with Door")
	get_tree().change_scene_to_file("res://I2.tscn")

func get_interaction_text():
	return interaction_text
