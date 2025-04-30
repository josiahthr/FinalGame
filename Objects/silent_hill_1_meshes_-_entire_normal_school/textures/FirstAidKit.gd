extends StaticBody3D

signal choice(picked_up: bool)

@export var interaction_text: String = "FirstAidKit"
@onready var yes_button := $"../../../CanvasLayer/Dialog/YesFAK"
@onready var no_button := $"../../../CanvasLayer/Dialog/Button3"
@onready var text := $"../../../CanvasLayer/Dialog/VBoxContainer/Dialogue"
@onready var FAK := $"../../../CanvasLayer/TextureRect"
@onready var FAKcol := $"../.."
@export var dialogue_line: Array[String] = [
	"[left]          
	
	
	
	
	
	
	
	
	
	
	
	
			  There is a [color=#2ffd4f]First Aid Kit[/color][/left].	
	[left]              Take it?[/left]",

]
@export var speaker_name: String = " "

var dialogue_index := 0
var can_interact := true

func interact():
	print("interacted with FirstAidKit")
	text.show()
	yes_button.visible = true
	no_button.visible = true
	text.visible = true
	FAK.visible = true
	yes_button.grab_focus()
	can_interact = false

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
	yes_button.visible = false
	no_button.visible = false
	text.visible = false
	FAK.visible = false
	
func _on_yes_fak_pressed() -> void:
	emit_signal("choice", true)
	_reset_interaction_ui()
	text.hide()
	FAKcol.queue_free()




func _on_button_3_pressed() -> void:
	emit_signal("choice", false)
	_reset_interaction_ui()
	text.hide()
	can_interact = true
