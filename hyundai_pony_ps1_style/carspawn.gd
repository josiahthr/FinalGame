extends Node3D
@export var current_lap = 0
@onready var current_lap_label: Label = get_node("HUDLayer/Lap/Max Lap/Current Lap")
@onready var race_theme: AudioStreamPlayer = get_node("RaceTheme")
@onready var start: Label = get_node("HUDLayer/RaceTheme")
@onready var finish: Label = get_node("HUDLayer/Finish")
@onready var Next: Button = get_node("HUDLayer/Button")
@onready var Replay: Button = get_node("HUDLayer/Button2")
@onready var done: AudioStreamPlayer = get_node("done")
@onready var best_lap_time_label: Label = get_node("HUDLayer/Label4")
var lap_time_2 = 0
var lap_time_1 = 0
var has_finished = false
var best_lap_time = 0.0

func _ready() -> void:
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
	if body.has_method("get_lap_time"):
		if current_lap == 0:
			lap_time_1 = body.get_lap_time()
			print("First Lap Time from body:", lap_time_1)
			best_lap_time = lap_time_1
		if current_lap == 1:
			lap_time_2 = body.get_lap_time()
			print("Second Lap Time from body:", lap_time_2)
			if lap_time_2 < best_lap_time:
				best_lap_time = lap_time_2
	if CheckpointCount.checkpoint == "4":
		current_lap += 1
		print ("Current Lap:", current_lap )
		current_lap_label.text = str(current_lap)
		CheckpointCount.checkpoint = "0"
		if body.has_method("reset_lap_timer"):
			body.reset_lap_timer()


func _physics_process(delta: float) -> void:
	if current_lap == 2 and not has_finished:
		finish_race()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://doom_e1m1_hangar_-_map/DLevel.tscn")
	
func finish_race():
	has_finished = true
	CheckpointCount.finished = true
	race_theme.stop()
	finish.show()
	Next.show()
	best_lap_time_label.text = "Best Lap: " + format_time(best_lap_time)
	best_lap_time_label.show()
	Replay.show()
	if is_instance_valid(done):
		print("Playing done audio")
		done.play()
	else:
		print("Audio stream player not valid.")
	
func _on_button_2_pressed() -> void:
	CheckpointCount.finished = false
	get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
	
	
func format_time(time_in_seconds: float) -> String:
	var minutes = int(time_in_seconds) / 60
	var seconds = int(time_in_seconds) % 60
	var milliseconds = int((time_in_seconds - int(time_in_seconds)) * 100)
	return "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
