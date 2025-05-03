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
var gt_theme_stream = preload("res://Gran Turismo 1 Menu Soundtrack - Arcade Mode Select [EURUSA].mp3")

func _physics_process(delta: float) -> void:
	if current_car == 1:
		nissanzx = true
		skyline = false
		back.hide()
		forward.show()
		nissanzxmod.show()
		nissanzxlab.show()
		skylinemod.hide()
		skylinelab.hide()
	if current_car == 2:
		skyline = true
		nissanzx = false
		nissanzxmod.hide()
		nissanzxlab.hide()
		skylinemod.show()
		skylinelab.show()
		forward.hide()
		back.show()
	if current_car == 3:
		current_car = 0
	if current_car == 0:
		current_car = 1

func _on_button_2_pressed() -> void:
	nissanzx = false
	skyline = true
	current_car += 1

func _on_button_3_pressed() -> void:
	nissanzx = true
	skyline = false
	current_car -= 1


func _on_button_pressed() -> void:
	MainMenu.stop_music()
	if nissanzx == true:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://fairlady2.tscn"
		
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
	if nissanzx == false:
		CarSelection.selected_car_scene = "res://Cars/Skyline.tscn"



func _on_button_9_pressed() -> void:
	get_tree().change_scene_to_file("res://ManuSelect.tscn")
