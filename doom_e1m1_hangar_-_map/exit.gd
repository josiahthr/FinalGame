extends StaticBody3D



func interact():
	print("leaving")
	get_tree().change_scene_to_file("res://Scenes/End.tscn")
