extends Node2D

@onready var TitanMod: Node3D = $Titan
@onready var Titanlab: Control = $TitanLabels
@onready var RX7Mod: Node3D = $RX7
@onready var RX7lab: Control = $RX7Labels
@onready var forward: Button = $Button
@onready var back: Button = $Button3

var current_car = 0

func _physics_process(delta: float) -> void:
	if current_car == 1:
		TitanMod.hide()
		Titanlab.hide()
		RX7Mod.show()
		RX7lab.show()
	if current_car == 0:
		RX7Mod.hide()
		RX7lab.hide()
		TitanMod.show()
		Titanlab.show()
		forward.show()

func _on_button_pressed() -> void:
	current_car = 1
	forward.hide()
	back.show()


func _on_button_10_pressed() -> void:
	get_tree().change_scene_to_file("res://ManuSelect.tscn")


func _on_button_2_pressed() -> void:
	if current_car == 0:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://Titan.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
	if current_car == 1:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://RX7.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")


func _on_button_3_pressed() -> void:
	current_car = 0
	forward.show()
	back.hide()
