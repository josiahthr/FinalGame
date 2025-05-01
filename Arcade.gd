extends Node2D

@onready var click: AudioStreamPlayer = $Panel/AudioStreamPlayer


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://SingleRace.tscn")
	


func _on_button_mouse_entered() -> void:
	click.play()



func _on_button_2_mouse_entered() -> void:
	click.play()


func _on_button_3_mouse_entered() -> void:
	click.play()


func _on_button_4_mouse_entered() -> void:
	click.play()


func _on_button_5_mouse_entered() -> void:
	click.play()


func _on_button_6_mouse_entered() -> void:
	click.play()


func _on_button_7_pressed() -> void:
	get_tree().change_scene_to_file("res://GTTITLE2.tscn")
