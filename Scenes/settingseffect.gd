extends Control

var fullscreen = false

func _ready() -> void:
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()

func _on_check_button_toggled(toggled_on: bool) -> void:
	if fullscreen == false:
		fullscreen = true
	if fullscreen == true:
		fullscreen = false
