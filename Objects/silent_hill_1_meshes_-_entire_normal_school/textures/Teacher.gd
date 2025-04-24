extends StaticBody3D

@export var interaction_text: String = "MidwichSign"
@onready var List := $"../../../../../../CanvasLayer/Dialog/TeacherList"
@export var dialogue_line: Array[String] = [
	"
	
	
	
	
	
	
	
	
	
	
	
	
	Moore, Ranaldo, Gordon...
This must be the list of teachers.",
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with MidwichSign")
	
func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		List.show() 
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
			"text": line,
			"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		List.hide()
		return null

func get_interaction_text():
	return interaction_text
