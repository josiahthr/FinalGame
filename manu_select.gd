extends Node2D


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nissan.tscn")


func _on_button_9_pressed() -> void:
	get_tree().change_scene_to_file("res://SingleRace.tscn")
