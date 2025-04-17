extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5
@export var mouse_sensitivity: float = 0.002
var indialogue = false

@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var _dialog : Control = $"../CanvasLayer/Dialog"


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

func _physics_process(delta: float) -> void:
	#interact collisions

	if $Neck/Camera3D/SeeCast.is_colliding():
		var target = $Neck/Camera3D/SeeCast.get_collider()
		#uncomment for hovers
		#if target != null and target.has_method("interact"):
		if target.has_method("interact") and Input.is_action_just_pressed("interact"):
			target.interact()
			_dialog.display_line(target.dialogue_text, target.speaker_name)
			#_dialog.display_line("[wave]hello[/wave]", "SPEAKER")
			
			
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
