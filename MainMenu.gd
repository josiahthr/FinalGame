extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer
var sensitivity: float = 0.0025
var volume: float = 1


func play_music(stream: AudioStream, force_restart := false) -> void:
	if force_restart or player.stream != stream:
		player.stream = stream
		player.play()

func stop_music():
	player.stop()
