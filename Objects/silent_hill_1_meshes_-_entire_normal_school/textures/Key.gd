extends StaticBody3D

signal choice(picked_up: bool)
signal key_taken(picked_up: bool)

@export var interaction_text: String = "Key"
@onready var yes_button := $"../../../CanvasLayer/Dialog/YesKEY"
@onready var no_button := $"../../../CanvasLayer/Dialog/Button4"
@onready var text := $"../../../CanvasLayer/Dialog/VBoxContainer/Dialogue"
@onready var KEY := $"../../../CanvasLayer/TextureRect2"
@onready var KEYcol := $"../.."
@export var dialogue_line: Array[String] = [
	"[left]          
	
	
	
	
	
	
	
	
	
	
	
	
			  There is a [color=#2ffd4f]Key[/color][/left].	
	[left]              Take it?[/left]",

]
@export var speaker_name: String = " "

var dialogue_index := 0
var can_interact := true

func interact():
	print("interacted with Key")
	text.show()
	yes_button.visible = true
	no_button.visible = true
	text.visible = true
	KEY.visible = true
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
	KEY.visible = false


func _on_yes_key_pressed() -> void:
	emit_signal("choice", true)
	emit_signal("key_taken", true)
	_reset_interaction_ui()
	text.hide()
	KEYcol.queue_free()


func _on_button_4_pressed() -> void:
	emit_signal("choice", false)
	_reset_interaction_ui()
	text.hide()
	can_interact = true
