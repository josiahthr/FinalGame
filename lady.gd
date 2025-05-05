extends VehicleBody3D


@export var max_rpm := 6000.0
@export var idle_rpm := 800.0
@export var rpm_sensitivity := 100.0
@export var max_torque := 20.0
@export var peak_rpm := 4000.0
@export var gear_ratio := 2
@export var final_drive_ratio := 3.9
@export var max_steering_angle = 0.30
@export var steering_speed = 2
@export var engine_power = 100.0
@export var speed_scale = 3.6
@onready var timer: Timer = get_node("../AnimationTimer")
@onready var GoTimer: Timer = get_node("../GoTimer")
@onready var RaceTimer: Timer = get_node("../RaceTimer")
@onready var LapTime: Label = get_node("../../HUDLayer/LapTime")
@export var orbit_duration = 5.0
var current_steering = 0.0
@onready var speedometer_label: Label = get_node("../../HUDLayer/speedometer_label")
@onready var Total_time: Label = get_node("../../HUDLayer/Total_time")
@onready var current_lap_label: Label = get_node("../../HUDLayer/Lap/Max Lap/Current Lap")
@onready var camera: Camera3D = get_node("Node3D/Camera3D")
@onready var camera_pivot: Node3D = get_node("Node3D")
@onready var start_timer: Label = get_node("../../HUDLayer/StartTimer")
@onready var GO: Label = get_node("../../HUDLayer/GO")
@onready var RPM: Label = get_node("../../HUDLayer/RPM")
@onready var Gear: Label = get_node("../../HUDLayer/Gear")
@export var wheel_radius := 0.4
var race_elapsed_time = 0
var race_lap_time = 0
var is_animating_camera: bool = true
var frozen = true
var current_rpm := 1000.0
var current_gear = 0
var shift_delay := 3
var last_shift_time := 0.0

func _ready():
	print("Timer:", timer)
	camera_pivot.global_position = global_position + Vector3(0, 1, 0)
	camera.transform.origin = Vector3(0.106, 0.243, 4.424)
	var tween = create_tween()
	tween.tween_property(camera_pivot, "rotation_degrees:y", 180, orbit_duration)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_LINEAR)

	await get_tree().create_timer(orbit_duration).timeout

	tween.kill()
	is_animating_camera = false
	print("animation is done starting start timer")
	start_timer.show()
	
	timer.start()
	await timer.timeout
	_on_timer_timeout()
	set_physics_process(true)
	set_process_input(true)
	
	if not speedometer_label:
		printerr("Error: SpeedometerLabel not found in HUDLayer!")
		

func _physics_process(delta):
	start_timer.text = "%2d" % time_to_start()
	if frozen:
		brake = 5
	else:
		brake = 0.0
		
		race_elapsed_time += delta
		race_lap_time += delta
		Total_time.text = format_time(race_elapsed_time)
		LapTime.text = format_time(race_lap_time)

	if (current_rpm >= max_rpm * 0.9 and current_gear < 5) and (Time.get_ticks_msec() - last_shift_time >= shift_delay * 1000):
		current_gear += 1
		current_rpm = lerp(current_rpm, idle_rpm + 1000, 0.1)
		last_shift_time = Time.get_ticks_msec()
	elif (current_rpm < idle_rpm + 500 and current_gear > 0) and (Time.get_ticks_msec() - last_shift_time >= shift_delay * 1000):
		current_gear -= 1
		current_rpm = max(idle_rpm, current_rpm)
		last_shift_time = Time.get_ticks_msec()
	var throttle = Input.get_axis("back", "forward")
	throttle = clamp(throttle, -0.3, 0.3)
	var wheel_speed = linear_velocity.length() / wheel_radius
	var rpm_from_wheels = (wheel_speed * 60.0) / (2.0 * PI) * gear_ratio * final_drive_ratio
	var target_rpm = max(idle_rpm, rpm_from_wheels)
	target_rpm += throttle * rpm_sensitivity
	current_rpm = lerp(current_rpm, target_rpm, delta * 5.0)
	current_rpm = clamp(current_rpm, idle_rpm, max_rpm)
	var engine_torque = get_torque(current_rpm) * throttle
	var wheel_torque = engine_torque * gear_ratio * final_drive_ratio
	engine_force = wheel_torque / wheel_radius
	var steering_input = Input.get_axis("right", "left")
	var steering_target = steering_input * max_steering_angle
	var steering_amount = abs(steering) / max_steering_angle
	current_steering = lerp(current_steering, steering_target, steering_speed * delta)
	steering = current_steering
	update_speedometer()
	
func update_speedometer():
	var current_velocity = linear_velocity
	var speed = current_velocity.length() * speed_scale
	if speedometer_label:
		speedometer_label.text = str(int(speed)) + " "
	if RPM:
		RPM.text = str(int(current_rpm)) + " RPM"
	if Gear:
		Gear.text = str(int(current_rpm)) + " RPM | Gear: " + str(current_gear + 1)


func time_to_start():
	var time_left = timer.time_left
	var second = int(time_left) % 60
	return [second]
	
func format_time(time_in_seconds: float) -> String:
	var minutes = int(time_in_seconds) / 60
	var seconds = int(time_in_seconds) % 60
	var milliseconds = int((time_in_seconds - int(time_in_seconds)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
	
func _on_timer_timeout():
	RaceTimer.start()
	print("we unfrozen")
	start_timer.hide()
	frozen = false
	GO.show()
	GoTimer.start()
	await GoTimer.timeout
	GO.hide()
	
func reset_lap_timer():
	race_lap_time = 0
	
func get_torque(rpm: float) -> float:
	var x = (rpm - peak_rpm) / peak_rpm
	var torque = max_torque * (1.0 - x * x)
	return max(torque, 0.0)
