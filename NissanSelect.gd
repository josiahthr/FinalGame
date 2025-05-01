extends Node2D

@onready var nissanzxmod: Node3D = $"300ZX"
@onready var nissanzxlab: Control = $"300zxLabels"
@onready var skylinemod: Node3D = $Skyline
@onready var skylinelab: Control = $SkylineLabels
var nissanzx = true
var skyline = false

func _physics_process(delta: float) -> void:
	if nissanzx == true:
		nissanzxmod.show()
		nissanzxlab.show()
	elif nissanzx == false:
		nissanzxmod.hide()
		nissanzxlab.hide()
	if skyline == true:
		skylinemod.show()
		skylinelab.show()
	elif skyline == false:
		skylinemod.hide()
		skylinelab.hide()


func _on_button_2_pressed() -> void:
	nissanzx = false
	skyline = true

func _on_button_3_pressed() -> void:
	nissanzx = true
	skyline = false
