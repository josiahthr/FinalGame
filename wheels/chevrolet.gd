extends Node2D

@onready var CorMod: Node3D = $Cor
@onready var Corlab: Control = $CorLabels
@onready var E46Mod: Node3D = $E46
@onready var E46lab: Control = $E46Labels
@onready var forward: Button = $Button
@onready var back: Button = $Button3

var current_car = 0

func _physics_process(delta: float) -> void:
	if current_car == 1:
		CorMod.hide()
		Corlab.hide()
		E46Mod.show()
		E46lab.show()
	if current_car == 0:
		E46Mod.hide()
		E46lab.hide()
		CorMod.show()
		Corlab.show()
		forward.show()

func _on_button_pressed() -> void:
	current_car = 1
	forward.hide()
	back.show()


func _on_button_10_pressed() -> void:
	get_tree().change_scene_to_file("res://ManuSelect.tscn")


func _on_button_2_pressed() -> void:
	MainMenu.stop_music()
	if current_car == 0:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://Corvette.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
	if current_car == 1:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://Malibu.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")


func _on_button_3_pressed() -> void:
	current_car = 0
	forward.show()
	back.hide()
