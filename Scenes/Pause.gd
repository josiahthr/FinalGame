extends Control


func _on_check_button_toggled(button_pressed: bool) -> void:
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	if button_pressed == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
