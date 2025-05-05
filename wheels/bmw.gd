extends Node2D

@onready var E30Mod: Node3D = $E30
@onready var E30lab: Control = $E30Labels
@onready var E46Mod: Node3D = $E46
@onready var E46lab: Control = $E46Labels
@onready var forward: Button = $Button
@onready var back: Button = $Button3

var current_car = 0

func _physics_process(delta: float) -> void:
	if current_car == 1:
		E30Mod.hide()
		E30lab.hide()
		E46Mod.show()
		E46lab.show()
	if current_car == 0:
		E46Mod.hide()
		E46lab.hide()
		E30Mod.show()
		E30lab.show()
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
		CarSelection.selected_car_scene = "res://E30.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
	if current_car == 1:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://E46.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")


func _on_button_3_pressed() -> void:
	current_car = 0
	forward.show()
	back.hide()
