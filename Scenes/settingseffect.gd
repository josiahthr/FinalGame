extends Control

func _ready() -> void:
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.play()
