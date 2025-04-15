extends StaticBody3D

@export var interaction_text: String = "Box One"

func interact():
	print("interacted with Box 1")
	queue_free()
	print("Consumed Box 1")


func get_interaction_text():
	return interaction_text
