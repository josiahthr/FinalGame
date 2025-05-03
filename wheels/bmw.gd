extends Node2D

@onready var E30Mod: Node3D = $E30
@onready var E30lab: Control = $E30Labels
@onready var E39Mod: Node3D = $E39
@onready var E39lab: Control = $E39Labels
@onready var forward: Button = $Button2
@onready var back: Button = $Button3

var current_car = 0

func _physics_process(delta: float) -> void:
	if current_car == 1:
		E30Mod.hide()
		E30lab.hide()
		E39Mod.show()
		E39lab.show()

func _on_button_pressed() -> void:
	current_car = 1


func _on_button_10_pressed() -> void:
	get_tree().change_scene_to_file("res://ManuSelect.tscn")


func _on_button_2_pressed() -> void:
	if current_car == 0:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://E30.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
