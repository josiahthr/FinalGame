extends Node2D

@onready var delay_timer: Timer = $Delay
@onready var animation_player = $ColorRect/AnimationPlayer
@onready var theme: AudioStreamPlayer = $AudioStreamPlayer
@onready var click: AudioStreamPlayer = $AudioStreamPlayer2
var fade_in_done = false

func _on_quick_arcade_pressed() -> void:
	get_tree().change_scene_to_file("res://Arcade.tscn")
	

func _on_simulation_mode_pressed() -> void:
	pass # Replace with function body.


func _on_replay_theater_pressed() -> void:
	pass # Replace with function body.


func _on_options_pressed() -> void:
	pass # Replace with function body.

func _ready() -> void:
	animation_player.play("fade_in")
	delay_timer.start()
	await delay_timer.timeout
	fade_in_done = true
	theme.play()


func _on_quick_arcade_mouse_entered() -> void:
	if fade_in_done == true:
		click.play()
	
func _on_simulation_mode_mouse_entered() -> void:
	if fade_in_done == true:
		click.play()

func _on_replay_theater_mouse_entered() -> void:
	if fade_in_done == true:
		click.play()

func _on_options_mouse_entered() -> void:
	if fade_in_done == true:
		click.play()
