extends StaticBody3D

@export var interaction_text: String = "SchoolMap"
@onready var _map_panel : Panel = $"../../../../../../CanvasLayer/Dialog/Map" 
@onready var yes_button := $"../../../../../../CanvasLayer/Dialog/Yes"
@onready var no_button := $"../../../../../../CanvasLayer/Dialog/Button2"
@export var dialogue_line: Array[String] = [
	"There is a [color=#0cebc2]School Map[/color].
	[left]         Take it?[/left]"
]
@export var speaker_name: String = " " 

var dialogue_index := 0

func interact():
	print("interacted with SchoolMap")
	
func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		_map_panel.visible = true 
		yes_button.visible = true
		no_button.visible = true
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
			"text": line,
			"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		_map_panel.visible = false 
		yes_button.visible = false
		no_button.visible = false
		return null

func get_interaction_text():
	return interaction_text
