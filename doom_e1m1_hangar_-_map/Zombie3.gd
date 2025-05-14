extends Node3D

@onready var player := $"../../CharacterBody3D"
@onready var sprite := $Sprite3D15
@onready var animation := $Sprite3D15/AnimationPlayer
@onready var shoot := $ZombieShoot
@onready var sight := $ZombieSight
@onready var nearby := $ZombieSight
@onready var painim := $"../../Control/ColorRect"
@onready var pain := $"../../Control/ColorRect/AnimationPlayer"
@onready var ammo := $Sprite3D16
@onready var body := $Sprite3D15
@onready var raycast := $Sprite3D15/RayCast3D
@export var front_texture: Texture2D
@export var back_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D
@export var dead_texture: Texture2D
@export var speed: float = 5
@export var stop_distance: float = 1.5
@export var sprite_update_cooldown: float = 1.5
@onready var navigation: NavigationAgent3D = $Sprite3D15/NavigationAgent3D
var see_player = false
var accumulated_time: float = 0.0
var can_shoot = true
@export var shoot_cooldown: float = 3
@export var shoot_range: float = 10.0

func _physics_process(delta: float) -> void:
	var target = raycast.get_collider()
	if see_player and Groanerstatus.Zalive2 and Groanerstatus.paused == false:
		var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
		if distance_to_player > stop_distance:
			navigation.set_target_position(player.global_transform.origin)
			var next_position = navigation.get_next_path_position()
			var direction = (next_position - global_transform.origin).normalized()
			global_translate(direction * speed * delta)
			accumulated_time += delta
			
		if distance_to_player <= shoot_range and target == player:
			shoot_player()
		if accumulated_time >= sprite_update_cooldown:
			print("paisjdbnfpoiajsdngfopiujasbndgoijbasdpoigjbaspdiujgnaosidjgniajsgd")
			update_sprite_relative_to_player()
			accumulated_time = 0.0
			

	if Groanerstatus.Zalive2 == false:
		print("zombie 3 dead")
		var speed = 0
		animation.play("dying")
		await get_tree().create_timer(1).timeout
		if is_instance_valid(ammo):
			ammo.get_parent().remove_child(ammo)
			var forward_dir = -global_transform.basis.z.normalized()
			get_tree().current_scene.add_child(ammo)
			var drop_position = global_transform.origin + forward_dir * 2.0
			var new_transform = ammo.global_transform
			new_transform.origin = drop_position
			ammo.global_transform = new_transform
			ammo.scale = Vector3(1, 1, 1)
			ammo.visible = true 
		global_transform.origin.y = -.9
		await get_tree().create_timer(10).timeout
		queue_free()

func update_sprite_relative_to_player():
	if Groanerstatus.Zalive2 == true:
		print("we updating part 3")
		var next_position = navigation.get_next_path_position()
		look_at(next_position, Vector3.UP)
		var direction = (next_position - global_transform.origin).normalized()
		var to_player = player.global_transform.origin - global_transform.origin
		var local_to_player = transform.basis.inverse() * to_player
		var angle_rad = atan2(local_to_player.x, -local_to_player.z)
		var angle_deg = rad_to_deg(angle_rad)

		if angle_deg < 0:
			angle_deg += 360

		if angle_deg >= 45 and angle_deg < 135:
			sprite.texture = right_texture
		elif angle_deg >= 135 and angle_deg < 225:
			sprite.texture = back_texture
		elif angle_deg >= 225 and angle_deg < 315:
			sprite.texture = left_texture
		else:
			sprite.texture = front_texture


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("gun_shoot"):
		sight.play()
		print("player is visible")
		see_player = true


func shoot_player():
	if not can_shoot:
		return
	if Groanerstatus.paused == false:
		can_shoot = false
		animation.play("shoot")
		await get_tree().create_timer(.5).timeout
		painim.visible = true
		pain.play("new_animation")
		await get_tree().create_timer(.5).timeout
		pain.stop()
		painim.visible = false
		shoot.play()
		player.health -= 10
		print("Enemy shoots!")
		await get_tree().create_timer(shoot_cooldown).timeout
		can_shoot = true
