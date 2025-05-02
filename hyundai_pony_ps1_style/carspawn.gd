extends Node3D
@export var current_lap = 0
@onready var current_lap_label: Label = get_node("HUDLayer/Lap/Max Lap/Current Lap")


func _ready() -> void:
	if CarSelection.selected_car_scene == "res://fairlady2.tscn":
		var car_scene = load(CarSelection.selected_car_scene)
		var car_instance = car_scene.instantiate()

		var position = Vector3(11.639, 0.196, -2.839)

		var rotation_degrees = Vector3(-1.8, -4.3, 3.0)
		var rotation_radians = rotation_degrees * (PI / 180.0)
		var rotation = rotation_degrees * (PI / 180.0)
		var basis = Basis.from_euler(rotation_radians)


		var transform = Transform3D(basis, position)
		car_instance.global_transform = transform

		add_child(car_instance)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if CheckpointCount.checkpoint == "4":
		current_lap += 1
		print ("Current Lap:", current_lap )
		current_lap_label.text = str(current_lap)
		CheckpointCount.checkpoint = "0"
