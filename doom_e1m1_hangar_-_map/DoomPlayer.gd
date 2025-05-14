extends CharacterBody3D


var SPEED = 14
const JUMP_VELOCITY = 6


@export var tilt_duration: float = 1.5
var tween: Tween
@export var mouse_sensitivity: = MainMenu.sensitivity
var current_target = null
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var pistolshot := $"../PistolShoot"
@onready var pistolanim := $"../Control/TextureRect4/AnimationPlayer"
@onready var ItemPickup := $"../ItemPickup"
@onready var Face := $"../Control/TextureRect3"
@onready var Item1 := $"../Sprite3D"
@onready var Item2 := $"../Sprite3D2"
@onready var Health := $"../Control/HEALTH"
@onready var Armor := $"../Control/ARMOR"
@onready var HUD := $"../Control"
@onready var pause := $"../Control2"
@onready var Ammo := $"../Control/AMMO"
@onready var pistol := $"../Control/TextureRect4"
@onready var pistolfire := $"../Control/TextureRect2"
@onready var AcidDamage := $"../AcidDamage"
@onready var Death1 := $"../Death1"
@onready var face_anim := $"../Control/TextureRect3/IDLE"
@onready var sight := $Neck/Camera3D/SeeCast
var health = 100
var armor = 0
var pistolammo = 50
var acid = false
var dead = false
var firstdead = false
var current_face_anim = ""
var is_shooting = false
var pause_menu = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_menu = true
		pause_screen()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion and dead == false:
			neck.rotate_y(-event.relative.x * mouse_sensitivity)
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(40))
	if event.is_action_pressed("shoot"):
		gun_shoot()

func _process(_delta):
	update_face_animation()
	face_anim.get_animation("idle").loop = true
	face_anim.get_animation("hurt").loop = true
	face_anim.get_animation("wounded").loop = true
	face_anim.get_animation("injured").loop = true
	face_anim.get_animation("dying").loop = true

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
			else:
				pass
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
	if dead == false and Groanerstatus.paused == false:
		if pistolammo > 0:
			if $Neck/Camera3D/SeeCast.is_colliding():
					var target = $Neck/Camera3D/SeeCast.get_collider()
					if target.has_method("shot"):
						target.shot()
			is_shooting = true
			pistolanim.play("shooting")
			face_anim.play("shoot")
			await get_tree().create_timer(.3).timeout
			pistolammo = pistolammo - 1
			pistolfire.show()
			pistolshot.play()
			await get_tree().create_timer(.1).timeout
			pistolfire.hide()
			is_shooting = false


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
		"combatarmor":
			armor = clamp(armor + value, 0, 200)
			print("Picked up combatarmor:", value)
		"ammoclip":
			pistolammo = pistolammo + value
			print("Picked up ammoclip:", value)
		_:
			print("Unknown item type:", item_type)

func apply_toxic_damage(amount: int):
	if dead == false and Groanerstatus.paused == false:
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
	
func update_face_animation():
	var new_anim = ""

	if health >= 80:
		new_anim = "idle"
	elif health >= 60 and health <= 79:
		new_anim = "hurt"
	elif health >= 40 and health <= 59:
		new_anim = "wounded"
	elif health >= 20 and health <= 39:
		new_anim = "injured"
	elif health >= 1 and health <= 19:
		new_anim = "dying"
	elif health == 0:
		new_anim = "dead"
	if is_shooting == true:
		new_anim = "shoot"

	if new_anim != current_face_anim:
		current_face_anim = new_anim
		face_anim.play(current_face_anim)
		
func pause_screen():
	if pause_menu == true:
		Groanerstatus.paused = true
		HUD.hide()
		pause.show()
	if pause_menu == false:
		Groanerstatus.paused = false
		HUD.show()
		pause.hide()

func _on_button_pressed() -> void:
	pause_menu = false
	pause_screen()
