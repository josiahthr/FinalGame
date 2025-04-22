extends Control

signal continue_pressed

@onready var _speaker : Label = $VBoxContainer/Speaker
@onready var _dialogue : RichTextLabel = $VBoxContainer/Dialogue
@onready var _continue : Button = $Box/Continue

func display_line( line : String, speaker : String = ""):
	_dialogue.text = line
	open()
	_continue.grab_focus()
	
func open():
	visible = true
	
func close():
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if visible and Input.is_action_just_pressed("confirm"):
		continue_pressed.emit()
