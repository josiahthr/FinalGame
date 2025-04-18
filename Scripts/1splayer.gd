extends CharacterBody3D


var SPEED = 10.0
const JUMP_VELOCITY = 4.5
@export var mouse_sensitivity: float = 0.002
var in_dialogue = false
var current_target = null

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var _dialog : Control = $"../CanvasLayer/Dialog"

func _ready():
	_dialog.continue_pressed.connect(_on_dialog_continue)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(40))

func _on_dialog_continue():
	if current_target and current_target.has_method("get_dialogue_data"):
		var data = current_target.get_dialogue_data()
		if data != null:
			_dialog.display_line(data["text"], data["speaker"])
		else:
			_dialog.close()
			in_dialogue = false
			current_target = null

func _physics_process(delta: float) -> void:

	if $Neck/Camera3D/SeeCast.is_colliding():
		var target = $Neck/Camera3D/SeeCast.get_collider()
		#uncomment for hovers
		#if target != null and target.has_method("interact"):
		if target.has_method("interact") and Input.is_action_just_pressed("interact") and not in_dialogue:
			target.interact()
			if target.has_method("get_dialogue_data"):
				var data = target.get_dialogue_data()
				if data != null:
					_dialog.display_line(data["text"], data["speaker"])
					in_dialogue = true
					current_target = target
			
			
	if not is_on_floor():
		velocity += get_gravity() * delta

	#[wave], [shake], [color]
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

	move_and_slide()
