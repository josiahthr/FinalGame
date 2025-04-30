extends MeshInstance3D

@onready var collision_area = get_node("Area3D")

func _ready():
	if collision_area:
		collision_area.body_entered.connect(_on_area_body_entered)
	else:
		printerr(": Area3D node not found!")

func _on_area_body_entered(body):
	print("we goin")
	get_tree().change_scene_to_file("res://Scenes/I11.tscn")
