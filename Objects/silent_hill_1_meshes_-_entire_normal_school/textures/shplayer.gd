extends CharacterBody3D


var SPEED = 10.0
const JUMP_VELOCITY = 10

@export var mouse_sensitivity: float = 0.002
var in_dialogue = false
var current_target = null

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var _dialog : Control = $"../CanvasLayer/Dialog"
@onready var yes_button := $"../CanvasLayer/Dialog/Yes"
@onready var no_button := $"../CanvasLayer/Dialog/Button2"

func _ready():
	_dialog.continue_pressed.connect(_on_dialog_continue)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if in_dialogue and is_instance_valid(current_target) and current_target.has_signal("choice"):
			current_target._on_button_2_pressed()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(40))
	elif in_dialogue and current_target and current_target.has_signal("choice"):
		if event.is_action_just_pressed("ui_up"):
			yes_button.grab_focus()
		elif event.is_action_just_pressed("ui_down"):
			no_button.grab_focus()
		elif event.is_action_just_pressed("ui_accept"):
			if yes_button.has_focus():
				yes_button.emit_signal("pressed")
			elif no_button.has_focus():
				no_button.emit_signal("pressed")

func _on_dialog_continue():
	if current_target and current_target.has_method("get_dialogue_data"):
		var data = current_target.get_dialogue_data()
		if data != null and current_target == $"../Sketchfab_model/root/GLTF_SceneRootNode/SM_FirstFloor_Lobby_80/Map":
			_dialog.display_line(data["text"], data["speaker"])
		else:
			_dialog.close()
			in_dialogue = false
			current_target = null
		if data != null:
			_dialog.display_line(data["text"], data["speaker"])
		else:
			_dialog.close()
			in_dialogue = false
			current_target = null

func _on_area_connect():
	if current_target and current_target.has_method("change_area"):
		get_tree().change_scene_to_file("res://Scenes/I7.tscn")

func _physics_process(delta: float) -> void:
	if in_dialogue:
		velocity.x = 0
		velocity.z = 0
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
		var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	if $Neck/Camera3D/Seecast.is_colliding():
		var target = $Neck/Camera3D/Seecast.get_collider()
		if is_instance_valid(target):
			if target.has_method("interact") and Input.is_action_just_pressed("interact"):
				target.interact()

				if target.has_method("get_dialogue_data"):
					var data = target.get_dialogue_data()
					if data != null:
						_dialog.display_line(data["text"], data["speaker"])
						in_dialogue = true
						current_target = target
						if target.has_signal("choice"):
							target.map_chosen.connect(_on_map_chosen)
					else:
						_dialog.close()
						in_dialogue = false
						current_target = null
			elif in_dialogue and Input.is_action_just_pressed("interact") and target == current_target and target.has_method("get_dialogue_data"):
				_on_dialog_continue()
	else:
		_dialog.close()
		in_dialogue = false
		current_target = null

	move_and_slide()
	
func _on_map_chosen(picked_up: bool):
	in_dialogue = false
	current_target = null
	print("Map picked up:", picked_up)
