extends StaticBody3D

@export var interaction_text: String = "Poster"

func interact():
	print("interacted with Poster")

func get_interaction_text():
	return interaction_text
