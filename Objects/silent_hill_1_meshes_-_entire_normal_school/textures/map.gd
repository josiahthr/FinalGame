extends StaticBody3D

signal map_chosen(picked_up: bool)

@export var interaction_text: String = "SchoolMap"
@onready var _map_panel : Panel = $"../../../../../../CanvasLayer/Dialog/Map"
@onready var yes_button := $"../../../../../../CanvasLayer/Dialog/Yes"
@onready var no_button := $"../../../../../../CanvasLayer/Dialog/Button2"
@export var dialogue_line: Array[String] = [
	"[left]          There is a [color=#0cebc2]School Map[/color][/left].	
	[left]          Take it?[/left]",

]
@export var speaker_name: String = " "

var dialogue_index := 0
var can_interact := true # Add a flag to prevent multiple interactions

func interact():
	if can_interact:
		print("interacted with SchoolMap")
		_map_panel.visible = true
		yes_button.visible = true
		no_button.visible = true
		yes_button.grab_focus()
		can_interact = false # Prevent further interactions until a choice is made

func get_dialogue_data():
	if dialogue_index < dialogue_line.size():
		var line = dialogue_line[dialogue_index]
		dialogue_index += 1
		return {
		"text": line,
		"speaker": speaker_name
		}
	else:
		dialogue_index = 0
		return null

func get_interaction_text():
	return interaction_text


func _reset_interaction_ui():
	_map_panel.visible = false
	yes_button.visible = false
	no_button.visible = false


func _on_yes_pressed() -> void:
	emit_signal("map_chosen", true)
	_reset_interaction_ui()
	queue_free()


func _on_button_2_pressed() -> void:
	emit_signal("map_chosen", false)
	_reset_interaction_ui()
	can_interact = true
