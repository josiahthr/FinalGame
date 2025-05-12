extends Node3D

@onready var player := $"../../CharacterBody3D"
@onready var sprite := $Sprite3D15
@export var front_texture: Texture2D
@export var back_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D
@export var speed: float = 2.0
@export var stop_distance: float = 1.5
@export var sprite_update_cooldown: float = 1.5
@onready var navigation: NavigationAgent3D = $Sprite3D15/NavigationAgent3D

var accumulated_time: float = 0.0

func _physics_process(delta: float) -> void:
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	navigation.set_target_position(player.global_transform.origin)
	var next_position = navigation.get_next_path_position()
	var direction = (next_position - global_transform.origin).normalized()
	
	accumulated_time += delta
	print(accumulated_time)
	if accumulated_time >= sprite_update_cooldown:
		print("paisjdbnfpoiajsdngfopiujasbndgoijbasdpoigjbaspdiujgnaosidjgniajsgd")
		update_sprite_relative_to_player()
		accumulated_time = 0.0

	if Groanerstatus.alive == true:
		global_translate(direction * speed * delta)

	if Groanerstatus.alive != true:
		var speed = 0
		global_translate(direction * speed * delta)

func update_sprite_relative_to_player():
	print("we updating")
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
