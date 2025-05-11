extends CharacterBody3D


var SPEED = 14
const JUMP_VELOCITY = 6


@export var tilt_duration: float = 1.5
var tween: Tween
@export var mouse_sensitivity: float = 0.002
var current_target = null
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var pistolshot := $"../PistolShoot"
@onready var pistolanim := $"../Control/TextureRect4/AnimationPlayer"
@onready var ItemPickup := $"../ItemPickup"
@onready var Item1 := $"../Sprite3D"
@onready var Item2 := $"../Sprite3D2"
@onready var Health := $"../Control/HEALTH"
@onready var Armor := $"../Control/ARMOR"
@onready var Ammo := $"../Control/AMMO"
@onready var pistol := $"../Control/TextureRect4"
@onready var pistolfire := $"../Control/TextureRect2"
@onready var AcidDamage := $"../AcidDamage"
@onready var Death1 := $"../Death1"
var health = 5
var armor = 0
var pistolammo = 50
var acid = false
var dead = false
var firstdead = false
#@onready var _dialog : Control = $"../CanvasLayer/Dialog"

#func _ready():
	#_dialog.continue_pressed.connect(_on_dialog_continue)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion and dead == false:
			neck.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(40))
	if event.is_action_pressed("shoot"):
		gun_shoot()

#func _on_dialog_continue():
	#if not in_dialogue or current_target == null:
		#return
	#var end_dialogue := false
	#if current_target.has_method("get_dialogue_data"):
		#var data = current_target.get_dialogue_data()
		#if data != null:
			#_dialog.display_line(data["text"], data["speaker"])
			#return
		#else:
			#end_dialogue = true
	#if current_target.has_method("this_is_random"):
		#end_dialogue = true
	#if end_dialogue == true:
		#_dialog.close()
		#in_dialogue = false
		#end_dialogue = false
		#current_target = null

#func _on_area_connect():
	#if current_target and current_target.has_method("change_area"):
		#get_tree().change_scene_to_file("res://Scenes/I7.tscn")

func _physics_process(delta: float) -> void:
	if health == 0:
		dead = true
		death()
	Health.text = str(health, "%")
	Armor.text = str(armor, "%")
	Ammo.text = str(pistolammo)
	if dead == false:
		if $Neck/Camera3D/SeeCast.is_colliding():
			var target = $Neck/Camera3D/SeeCast.get_collider()
			#uncomment for hovers
			#if target != null and target.has_method("interact"):
			if target.has_method("interact") and Input.is_action_just_pressed("interact"):
				target.interact()
				#if target.has_method("get_dialogue_data"):
					#var data = target.get_dialogue_data()
					#if data != null:
						#_dialog.display_line(data["text"], data["speaker"])
						#in_dialogue = true
						#current_target = target
				
				
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
	
	
func gun_shoot():
	if dead == false:
		if pistolammo > 0:
			pistolanim.play("shooting")
			await get_tree().create_timer(.3).timeout
			pistolammo = pistolammo - 1
			pistolfire.show()
			pistolshot.play()
			await get_tree().create_timer(.1).timeout
			pistolfire.hide()


func apply_item_pickup(item_type: String, value: int) -> void:
	match item_type:
		"bonushealth":
			health = health + value
			print("Picked up bonushealth:",  value)
		"bonusarmor":
			armor = armor + value
			print("Picked up bonusarmor:", value)
		"ammo":
			pistolammo += value
			print("Picked up ammo:", value)
		"armor":
			armor = clamp(armor + value, 0, 100)
			print("Picked up armor:", value)
		_:
			print("Unknown item type:", item_type)

func apply_toxic_damage(amount: int):
	if dead == false:
		health = max(health - amount, 0)
		AcidDamage.play()
	
func death():
	if dead and not firstdead:
		firstdead = true
		Death1.play()
		lowergun()
		var target_position = camera.position - Vector3(0, 1.5, 0)
		tween = create_tween()
		tween.tween_property(camera, "position", target_position, tilt_duration)


func lowergun():
	var target_ui_pos = pistol.position + Vector2(0, 220)
	tween = create_tween()
	tween.tween_property(pistol, "position", target_ui_pos, tilt_duration)
