extends Control

func _ready() -> void:
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameSelect.tscn")
	



func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn")



func _on_button_2_pressed() -> void:
	get_tree().quit()
