extends Node2D



func _on_button_10_pressed() -> void:
	get_tree().change_scene_to_file("res://ManuSelect.tscn")


func _on_button_2_pressed() -> void:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://EVO.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
