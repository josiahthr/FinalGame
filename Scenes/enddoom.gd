extends Node2D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://doom_e1m1_hangar_-_map/DLevel.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/I1.tscn")


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/silent_hill_1_meshes_-_entire_normal_school/textures/scene.tscn")


func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file("res://GTTITLE.tscn")
