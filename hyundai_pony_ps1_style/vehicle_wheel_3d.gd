extends VehicleWheel3D

@export var normal_friction_slip = 2
@export var high_slip_friction = 2

var vehicle_body: VehicleBody3D

func _ready():
	vehicle_body = get_parent() as VehicleBody3D
	if not vehicle_body:
		printerr("Error: VehicleWheel must be a child of a VehicleBody3D!")

func _physics_process(delta):
	if vehicle_body:
		var steering_amount = abs(vehicle_body.steering) / vehicle_body.max_steering_angle
		wheel_friction_slip = lerp(normal_friction_slip, high_slip_friction, steering_amount)
