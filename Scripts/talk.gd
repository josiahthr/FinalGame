extends StaticBody3D

@export var interaction_text: String = "Talk to me"

func interact():
	print("Interacted with talk box")



func get_interaction_text():
	return interaction_text
