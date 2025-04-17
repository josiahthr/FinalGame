extends StaticBody3D

@export var interaction_text: String = "Poster"
@export var dialogue_text: String = "This is the poster's dialogue."
@export var speaker_name: String = "Poster" 

func interact():
	print("interacted with Poster")

func get_interaction_text():
	return interaction_text
