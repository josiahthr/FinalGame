extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

func play_music(stream: AudioStream, force_restart := false) -> void:
	if force_restart or player.stream != stream:
		player.stream = stream
		player.play()

func stop_music():
	player.stop()
