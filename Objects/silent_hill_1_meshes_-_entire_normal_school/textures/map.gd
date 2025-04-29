extends StaticBody3D

signal choice(picked_up: bool)

@export var interaction_text: String = "SchoolMap"
@onready var _map_panel : Panel = $"../../../../../../CanvasLayer/Dialog/Map"
@onready var yes_button := $"../../../../../../CanvasLayer/Dialog/Yes"
@onready var mapcol := $".."
@onready var no_button := $"../../../../../../CanvasLayer/Dialog/Button2"
@onready var text := $"../../../../../../CanvasLayer/Dialog/VBoxContainer/Dialogue"
@onready var mapgone := $"../../../../../../mapgone"
@export var target = null


@export var dialogue_line: Array[String] = [

	"[left]          
	
	
	
	
	
	
	
	
	
	
	
	
			  There is a [color=#0cebc2]School Map[/color][/left].	
	[left]              Take it?[/left]",

]
@export var speaker_name: String = " "

var dialogue_index := 0
var can_interact := true


func interact():
	print("interacted with SchoolMap")
	_map_panel.visible = true
	yes_button.visible = true
	no_button.visible = true
	text.visible = true
	yes_button.focus_mode = Control.FOCUS_ALL
	no_button.focus_mode = Control.FOCUS_ALL
	yes_button.grab_focus()
	can_interact = false
	print ("cant interact")


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
	text.visible = false
	yes_button.focus_mode = Control.FOCUS_NONE
	no_button.focus_mode = Control.FOCUS_NONE


func _on_yes_pressed() -> void:
		emit_signal("choice", true)
		_reset_interaction_ui()
		text.hide()
		#"I was chosen by God because I am the best programmer 
		#on the planet and God boosted my IQ with divine intellect." -Terry A. Davis
		mapgone.show()
		mapcol.queue_free()


func _on_button_2_pressed() -> void:
	emit_signal("choice", false)
	_reset_interaction_ui()
	text.hide()
	can_interact = true
	print ("can interact")
	yes_button.grab_focus()
	no_button.grab_focus()
	
