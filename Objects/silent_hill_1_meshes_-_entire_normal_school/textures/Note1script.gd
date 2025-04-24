extends StaticBody3D

@export var interaction_text: String = "MidwichSign"
@onready var Note1 := $"../../../../../../CanvasLayer/Dialog/Note1"
@export var dialogue_line: Array[String] = [
	"
	
	
	
	
	
	
	
	
	
	
	
	
	
	It's written in blood.",
	"
	
	
	
	[color=#0cebc2]
	10:00
	\"Alchemy Laboratory\"
	
	Gold in an old man's palm.
	The future hidden in his fist.
	Exchange for sage's water.[/color]"
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with MidwichSign")
	
func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		Note1.show() 
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
			"text": line,
			"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		Note1.hide()
		return null

func get_interaction_text():
	return interaction_text
