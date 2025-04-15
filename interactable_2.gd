extends StaticBody3D

@export var interaction_text: String = "Box 2"

func interact():
	print("interacted with box 2")
	queue_free()
	print("Consumed Box 1")

func get_interaction_text():
	return interaction_text
