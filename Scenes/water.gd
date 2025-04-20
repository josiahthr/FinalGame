extends MeshInstance3D

@export var reset_position: Vector3 = Vector3(0, 0, 43)
@onready var collision_area = get_node("Area3D")

func _ready():
	if collision_area:
		collision_area.body_entered.connect(_on_area_body_entered)
	else:
		printerr(": Area3D node not found!")

func _on_area_body_entered(body):
	if body.name == "Character":
		body.move_to_position(reset_position)
