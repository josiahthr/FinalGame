extends Control


func _ready() -> void:
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/I1.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Objects/silent_hill_1_meshes_-_entire_normal_school/textures/scene.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
