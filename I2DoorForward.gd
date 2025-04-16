extends StaticBody3D


@export var interaction_text: String = "I2DoorForward"

func interact():
	print("interacted with I2DoorForward")
	get_tree().change_scene_to_file("res://I3.tscn")

func get_interaction_text():
	return interaction_text
