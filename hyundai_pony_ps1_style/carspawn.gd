extends Node3D

func _ready() -> void:
	if CarSelection.selected_car_scene == "res://fairlady2.tscn":
		var car_scene = load(CarSelection.selected_car_scene)
		var car_instance = car_scene.instantiate()

		# Set position (where you want the car to spawn)
		var position = Vector3(11.639, 0.196, -2.839)  # X, Y, Z

		# Set rotation in degrees (you can adjust these values)
		var rotation_degrees = Vector3(-1.8, -4.3, 3.0)  # pitch, yaw, roll
		var rotation_radians = rotation_degrees * (PI / 180.0)
		# Convert rotation to radians for Basis
		var rotation = rotation_degrees * (PI / 180.0)
		var basis = Basis.from_euler(rotation_radians)

		# Set transform
		var transform = Transform3D(basis, position)
		car_instance.global_transform = transform

		# Add the car to the scene
		add_child(car_instance)
