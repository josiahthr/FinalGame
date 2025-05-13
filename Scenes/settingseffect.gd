extends Control

var fullscreen = false


func _ready() -> void:
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()




func _on_check_button_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if button_pressed == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
