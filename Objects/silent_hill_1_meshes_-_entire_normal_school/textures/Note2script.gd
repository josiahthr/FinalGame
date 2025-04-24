extends StaticBody3D

@export var interaction_text: String = "Note2"
@onready var Note2 := $"../../../../../../CanvasLayer/Dialog/Note2"
@onready var text := $"../../../../../../CanvasLayer/Dialog/VBoxContainer/Dialogue"
@export var dialogue_line: Array[String] = [
	"
	
	
	
	
	
	
	
	
	
	
	
	
	
	It's written in blood.",
	"
	
	
	
	[color=#0cebc2]
	5:00
	\"Darkness that brings
	the choking heat\"
	
	Flames render the silence,
	awakening the hungry beast.
	Open time's door to beckon prey.[/color]"
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with Note2")
	text.show()
	
func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		Note2.show() 
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
			"text": line,
			"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		Note2.hide()
		return null

func get_interaction_text():
	return interaction_text
