extends Control

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/I1.tscn")





func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
