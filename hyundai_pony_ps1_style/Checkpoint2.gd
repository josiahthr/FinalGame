extends Area3D



func _on_body_entered(body: Node3D) -> void:
	if CheckpointCount.checkpoint == "1":
		CheckpointCount.checkpoint = "2"
