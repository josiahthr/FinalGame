extends Node3D


signal jump
@onready var navigation: NavigationAgent3D = $NavigationAgent3D
@onready var local_anim: AnimationPlayer = get_node("AnimationPlayer2")
var current_animation: String = "DOG_skeleton|DOG_skeleton|DOG_skeleton|DOG_anm"
@export var speed: float = 6.0
@onready var player: CharacterBody3D = get_node("../../Player") 
var player_in_sight = false
var jump_start_time: float = 8.5
var jump_end_time: float = 10
var first_jump = true

func _physics_process(delta: float) -> void:
	if player_in_sight and  player and navigation:
		var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
		if distance_to_player <= 6:
			start_jump()
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
		
		

func start_jump() -> void:
	if first_jump == true:
		print("jump")
		local_anim.play(current_animation)
		local_anim.seek(jump_start_time, true)
		first_jump = false
	elif first_jump == false:
		await get_tree().create_timer(1.5).timeout
		local_anim.stop()
