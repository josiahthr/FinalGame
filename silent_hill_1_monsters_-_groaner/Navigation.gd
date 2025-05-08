extends Node3D

@onready var navigation: NavigationAgent3D = $NavigationAgent3D

@export var speed: float = 3.0

@onready var player: CharacterBody3D = get_node("../../../Player") 

func _physics_process(delta: float) -> void:
	if player and navigation:
		navigation.set_target_position(player.global_transform.origin)
		var next_position = navigation.get_next_path_position()
		var direction = (next_position - global_transform.origin).normalized()
		if direction.length() > 0.1:
			look_at(next_position, Vector3.UP)
		global_translate(direction * speed * delta)
		
