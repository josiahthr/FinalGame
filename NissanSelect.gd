extends Node2D

@onready var nissanzxmod: Node3D = $"300ZX"
@onready var nissanzxlab: Control = $Control
var nissanzx = true

func _physics_process(delta: float) -> void:
	if nissanzx == true:
		nissanzxmod.show()
		nissanzxlab.show()
	elif nissanzx == false:
		nissanzxmod.hide()
		nissanzxlab.hide()


func _on_button_2_pressed() -> void:
	nissanzx = false
