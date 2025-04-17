extends StaticBody3D

@export var interaction_text: String = "Mattress"
@export var dialogue_text: String = "This is the Mattress dialogue."
@export var speaker_name: String = "Mattress" 

func interact():
	print("interacted with Mattress LIGHTLY")

func get_interaction_text():
	return interaction_text
