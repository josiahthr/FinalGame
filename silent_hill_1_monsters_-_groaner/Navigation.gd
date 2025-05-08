extends Node3D


@onready var navigation: NavigationAgent3D = $NavigationAgent3D
@onready var local_anim: AnimationPlayer = get_node("AnimationPlayer2")
var current_animation: String = "DOG_skeleton|DOG_skeleton|DOG_skeleton|DOG_anm"
@export var speed: float = 6.0
@onready var player: CharacterBody3D = get_node("../../Player") 
var player_in_sight = false
var jump_start_time: float = 8.5
var jump_end_time: float = 10
var can_jump := true
var jump_cooldown := 3.0
var is_jumping := false
var can_move = true

func _physics_process(delta: float) -> void:
	if player_in_sight and player and navigation and can_move:
		var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
		if distance_to_player <= 6:
			start_jump_async()
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

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		player_in_sight = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body == player:
		player_in_sight = false

func start_jump_async() -> void:
	if can_jump and not is_jumping and Groanerstatus.alive == true:
		is_jumping = true
		can_jump = false
		print("jump")
		player.health -= 5 
		local_anim.play(current_animation)
		local_anim.seek(jump_start_time, true)
		await get_tree().create_timer(1.5).timeout 
		local_anim.stop()
		is_jumping = false
		await get_tree().create_timer(jump_cooldown).timeout
		can_jump = true
