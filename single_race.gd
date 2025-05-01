extends Node2D

@onready var click: AudioStreamPlayer = $AudioStreamPlayer




func _on_button_mouse_entered() -> void:
	click.play()


func _on_button_2_mouse_entered() -> void:
	click.play()


func _on_button_3_mouse_entered() -> void:
	click.play()


func _on_button_7_mouse_entered() -> void:
	click.play()


func _on_button_7_pressed() -> void:
	get_tree().change_scene_to_file("res://Arcade.tscn")
