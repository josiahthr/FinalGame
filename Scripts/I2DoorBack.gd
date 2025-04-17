extends StaticBody3D


@export var interaction_text: String = "I2DoorBack"

func interact():
	print("interacted with I2DoorBack")
	get_tree().change_scene_to_file("res://Scenes/I1.tscn")

func get_interaction_text():
	return interaction_text
