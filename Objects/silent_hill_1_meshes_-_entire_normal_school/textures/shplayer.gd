extends CharacterBody3D


var SPEED = 10.0
const JUMP_VELOCITY = 10

@export var mouse_sensitivity: float = 0.002
var in_dialogue = false
var current_target = null
var has_key: bool = false

@onready var gun := $Neck/Camera3D/Sketchfab_Scene
@onready var gun_sight := $Neck/Camera3D/Sketchfab_Scene/RayCast3D
@onready var neck := $Neck
@onready var fade_player := $"../Control/ColorRect/AnimationPlayer"
@onready var fade_player_heading := $"../Control/Label/AnimationPlayer"
@onready var dog := $"../NavigationRegion3D/Sketchfab_Scene3"
@onready var camera := $Neck/Camera3D
@onready var _dialog : Control = $"../CanvasLayer/Dialog"
@onready var yes_button := $"../CanvasLayer/Dialog/Yes"
@onready var no_button := $"../CanvasLayer/Dialog/Button2"
@onready var flash := $Neck/Camera3D/Sketchfab_Scene/MeshInstance3D
@onready var god_light := $"../Sketchfab_model/root/GLTF_SceneRootNode/SM_InnerCourtyard_83/OmniLight3D"
@export var tilt_angle_degrees: float = 20.0
@export var tilt_duration: float = 0.05
var current_yes_button : Button
var current_no_button : Button
var tween: Tween
var health = 5
var death = false

func _ready():
	_dialog.continue_pressed.connect(_on_dialog_continue)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		gun_shoot()
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if in_dialogue and is_instance_valid(current_target) and current_target.has_signal("choice"):
			if current_no_button and is_instance_valid(current_no_button):
				current_no_button.emit_signal("pressed")
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(40))
	elif in_dialogue and current_target:
		if Input.is_action_just_pressed("ui_up") and current_yes_button:
			current_yes_button.grab_focus()
		elif Input.is_action_just_pressed("ui_down") and current_no_button:
			current_no_button.grab_focus()
		elif Input.is_action_just_pressed("ui_accept"):
			if current_yes_button and current_yes_button.has_focus():
				current_yes_button.emit_signal("pressed")
			elif current_no_button and current_no_button.has_focus():
				current_no_button.emit_signal("pressed")

func _on_dialog_continue():
	if current_target and current_target.has_method("get_dialogue_data"):
		var data = current_target.get_dialogue_data()
		if data != null:
			_dialog.display_line(data["text"], data["speaker"])
		else:
			_dialog.close()
			in_dialogue = false
			current_target = null
			if current_target.has_method("reset_dialogue"):
				current_target.reset_dialogue()

func _on_area_connect():
	if current_target and current_target.has_method("change_area"):
		get_tree().change_scene_to_file("res://Scenes/I7.tscn")

func _physics_process(delta: float) -> void:
	if health <= 0 and death == false:
		print("we should be dying")
		death = true
		gameover_show()
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
				print("Set current_target:", target)
				if target.has_method("get_dialogue_data"):
					var data = target.get_dialogue_data()
					if data != null:
						_dialog.display_line(data["text"], data["speaker"])
						in_dialogue = true
						current_target = target
						if target.has_signal("key_taken"):
							target.connect("key_taken", Callable(self, "_on_key_taken"))
						if target.has_node("../CanvasLayer/Dialog/YesFAK"):
							current_yes_button = target.get_node("../CanvasLayer/Dialog/YesFAK")
							current_no_button = target.get_node("../CanvasLayer/Dialog/Button3")
							current_yes_button.focus_mode = Control.FOCUS_ALL
							current_no_button.focus_mode = Control.FOCUS_ALL
							current_yes_button.grab_focus()
						elif target.has_node("../CanvasLayer/Dialog/Yes"):
							current_yes_button = target.get_node("../CanvasLayer/Dialog/Yes")
							current_no_button = target.get_node("../CanvasLayer/Dialog/Button2")
							target.choice.connect(_on_map_chosen)
							current_yes_button.focus_mode = Control.FOCUS_ALL
							current_no_button.focus_mode = Control.FOCUS_ALL
							current_yes_button.grab_focus()
						if target.has_signal("choice"):
							target.choice.connect(_on_map_chosen)
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
	current_yes_button = null
	current_no_button = null
	print("Map picked up:", picked_up)
	
func _on_key_taken(picked_up: bool):
	has_key = picked_up
	print("Key taken! has_key is now: ", has_key)
	god_light.show()
	var door = get_tree().get_current_scene().get_node_or_null("Sketchfab_model/root/GLTF_SceneRootNode/SM_DoorSchoolInnerCourtyard_002_14/CourtyardDoor2/StaticBody3D")
	if door and door.has_method("set_has_key"):
		door.set_has_key(true)
	else:
		print("Could not find the door or method missing.")

func gun_shoot():
	flash.show()
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(gun, "rotation_degrees:x", tilt_angle_degrees, tilt_duration)
	tween.tween_property(gun, "rotation_degrees:x", 0.0, tilt_duration)
	await get_tree().create_timer(0.5).timeout
	flash.hide()
	if gun_sight.is_colliding():
		var target = gun_sight.get_collider()
		if is_instance_valid(target):
			if target.has_method("shot"):
				print("shooting")
				target.shot()
				
func gameover_show():
	if death == true:
		Groanerstatus.can_move = false
		await get_tree().create_timer(1).timeout
		print("were dying")
		fade_player.play("fade_to_black")
		fade_player_heading.play("Heading")
