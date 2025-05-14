extends Control

signal continue_pressed

@onready var _speaker : Label = $VBoxContainer/Speaker
@onready var blip = $AudioStreamPlayer
@onready var blip2 = $AudioStreamPlayer2
@onready var _dialogue : RichTextLabel = $VBoxContainer/Dialogue
@onready var _continue : Button = $Yes

func display_line( line : String, speaker : String = ""):
	_dialogue.text = line
	open()
	
	
func open():
	visible = true
	
func close():
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if visible and Input.is_action_just_pressed("confirm"):
		continue_pressed.emit()


func _on_yes_focus_entered() -> void:
	blip.play()


func _on_yes_fak_focus_entered() -> void:
	blip.play()


func _on_yes_key_focus_entered() -> void:
	blip.play()


func _on_button_2_focus_entered() -> void:
	blip.play()


func _on_button_3_focus_entered() -> void:
	blip.play()


func _on_button_4_focus_entered() -> void:
	blip.play()


func _on_yes_pressed() -> void:
	blip2.play()


func _on_yes_fak_pressed() -> void:
	blip2.play()


func _on_yes_key_pressed() -> void:
	blip2.play()


func _on_button_2_pressed() -> void:
	blip2.play()


func _on_button_3_pressed() -> void:
	blip2.play()


func _on_button_4_pressed() -> void:
	blip2.play()
