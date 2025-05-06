extends Node3D
@export var current_lap = 0
@onready var current_lap_label: Label = get_node("HUDLayer/Lap/Max Lap/Current Lap")
@onready var race_theme: AudioStreamPlayer = get_node("RaceTheme")
@onready var start: Label = get_node("HUDLayer/RaceTheme")
@onready var finish: Label = get_node("HUDLayer/Finish")
@onready var Next: Button = get_node("HUDLayer/Button")
@onready var Replay: Button = get_node("HUDLayer/Button2")
@onready var done: AudioStreamPlayer = get_node("done")

var has_finished = false

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
	pass
	
func finish_race():
	has_finished = true
	CheckpointCount.finished = true
	race_theme.stop()
	finish.show()
	Next.show()
	Replay.show()
	if is_instance_valid(done):  # Ensure audio player is valid
		print("Playing done audio")
		done.play()
	else:
		print("Audio stream player not valid.")
	


func _on_button_2_pressed() -> void:
	CheckpointCount.finished = false
	get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
