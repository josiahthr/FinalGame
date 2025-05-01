extends Node2D

@onready var nissanzxmod: Node3D = $"300ZX"
@onready var nissanzxlab: Control = $"300zxLabels"
@onready var skylinemod: Node3D = $Skyline
@onready var skylinelab: Control = $SkylineLabels
@onready var forward: Button = $Button2
@onready var back: Button = $Button3
var nissanzx = true
var skyline = false
var current_car := 0

func _physics_process(delta: float) -> void:
	if current_car == 1:
		nissanzx = true
		back.hide()
		forward.show()
	if current_car == 2:
		skyline = true
		forward.hide()
		back.show()
	if current_car == 3:
		current_car = 0
	if current_car == 0:
		current_car = 1
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
	current_car += 1

func _on_button_3_pressed() -> void:
	nissanzx = true
	skyline = false
	current_car -= 1


func _on_button_pressed() -> void:
	if nissanzx == true:
		pass
	if nissanzx == false:
		pass
