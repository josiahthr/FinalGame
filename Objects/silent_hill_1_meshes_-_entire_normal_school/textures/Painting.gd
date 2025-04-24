extends StaticBody3D

@export var interaction_text: String = "MidwichSign"
@onready var Painting := $"../../../../../../CanvasLayer/Dialog/Painting"
@export var dialogue_line: Array[String] = [
	# I dont wanna talk about it
	"
	
	
	
	
	
	
	
	
	
	
	
	
	A picture of a door.",
	"
	
	
	
	
	
	
	
	
	
	
	
	
	I don't know who drew it,
	 but it is certainly in bad taste.",
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with MidwichSign")
	
func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		Painting.show() 
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
			"text": line,
			"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		Painting.hide()
		return null

func get_interaction_text():
	return interaction_text
