extends Node3D

@onready var DisplayCard: Panel = $Panel
@onready var timer: Timer = $Panel/Timer


@export var display_duration: float = 3.0

func _ready() -> void:
	DisplayCard.show()
	timer.wait_time = display_duration
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _on_timer_timeout():
	DisplayCard.hide()
	print("Title card finished, transitioning...")
