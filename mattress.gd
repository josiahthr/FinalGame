extends StaticBody3D

@export var interaction_text: String = "Mattress"

func interact_light():
	print("interacted with Mattress LIGHTLY")

func get_interaction_text():
	return interaction_text
