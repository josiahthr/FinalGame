extends Node3D

@onready var player := $"../../CharacterBody3D"
@onready var sprite := $Sprite3D15
@export var front_texture: Texture2D
@export var back_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D
@export var speed: float = 2.0
@export var stop_distance: float = 1.5
@onready var navigation: NavigationAgent3D = $Sprite3D15/NavigationAgent3D

func _process(_delta):
	update_sprite_by_angle()

func update_sprite_by_angle():
	var to_player = (player.global_transform.origin - global_transform.origin).normalized()
	var facing_angle = rad_to_deg(atan2(to_player.x, to_player.z))
	
	
	if facing_angle < 0:
		facing_angle += 360

	if facing_angle >= 45 and facing_angle < 135:
		sprite.texture = right_texture
	elif facing_angle >= 135 and facing_angle < 225:
		sprite.texture = back_texture
	elif facing_angle >= 225 and facing_angle < 315:
		sprite.texture = left_texture
	else:
		sprite.texture = front_texture

func _physics_process(delta: float) -> void:
		var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
		navigation.set_target_position(player.global_transform.origin)
		var next_position = navigation.get_next_path_position()
		var direction = (next_position - global_transform.origin).normalized()
		if direction.length() > 0.1:
			look_at(next_position, Vector3.UP)
		if Groanerstatus.alive == true:
			global_translate(direction * speed * delta)
		if Groanerstatus.alive != true:
			var speed = 0
			global_translate(direction * speed * delta)
