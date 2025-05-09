extends VehicleBody3D

@export var max_steering_angle = 0.30
@export var steering_speed = 2
@export var engine_power = 100.0
@export var speed_scale = 3.6
@export var current_lap = 0
@onready var timer: Timer = get_node("../../Timer")
@export var orbit_duration = 5.0

var current_steering = 0.0
@onready var speedometer_label: Label = get_node("../../HUDLayer/speedometer_label")
@onready var current_lap_label: Label = get_node("../../HUDLayer/Lap/Max Lap/Current Lap")
@onready var camera: Camera3D = get_node("Node3D/Camera3D")
@onready var camera_pivot: Node3D = get_node("Node3D")
@onready var start_timer: Label = get_node("../../HUDLayer/StartTimer")

var is_animating_camera: bool = true
func _ready():
	set_physics_process(false)
	set_process_input(false)
	camera_pivot.global_position = global_position + Vector3(0, 1, 0)
	camera.transform.origin = Vector3(0.106, 0.243, 4.424)
	var tween = create_tween()
	tween.tween_property(camera_pivot, "rotation_degrees:y", 180, orbit_duration)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)

	await get_tree().create_timer(orbit_duration).timeout

	tween.kill()
	is_animating_camera = false
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	set_physics_process(true)
	set_process_input(true)
	if not speedometer_label:
		printerr("Error: SpeedometerLabel not found in HUDLayer!")

func _physics_process(delta):
	start_timer.text = "%2d" % time_to_start()
	var steering_input = Input.get_axis("right", "left")
	var steering_target = steering_input * max_steering_angle
	var steering_amount = abs(steering) / max_steering_angle
	current_steering = lerp(current_steering, steering_target, steering_speed * delta)
	steering = current_steering
	engine_force = Input.get_axis("back", "forward") * engine_power
	update_speedometer()
	
func update_speedometer():
	var current_velocity = linear_velocity
	var speed = current_velocity.length() * speed_scale
	if speedometer_label:
		speedometer_label.text = str(int(speed)) + " "


func _on_area_3d_body_entered(body: Node3D) -> void:
	current_lap += 1
	print ("Current Lap:", current_lap )
	current_lap_label.text = str(current_lap)

func time_to_start():
	var time_left = timer.time_left
	var second = int(time_left) % 60
	return [second]
	
func _on_timer_timeout():
	start_timer.hide()
