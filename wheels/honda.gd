extends Node2D

@onready var IntegraMod: Node3D = $Integra
@onready var Integralab: Control = $IntegraLabels
@onready var S2KMod: Node3D = $S2K
@onready var S2Klab: Control = $S2KLabels
@onready var forward: Button = $Button
@onready var back: Button = $Button3

var current_car = 0

func _physics_process(delta: float) -> void:
	if current_car == 1:
		IntegraMod.hide()
		Integralab.hide()
		S2KMod.show()
		S2Klab.show()
	if current_car == 0:
		S2KMod.hide()
		S2Klab.hide()
		IntegraMod.show()
		Integralab.show()
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
		CarSelection.selected_car_scene = "res://Integra.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")
	if current_car == 1:
		print("we should be goin")
		CarSelection.selected_car_scene = "res://S2000.tscn"
		get_tree().change_scene_to_file("res://hyundai_pony_ps1_style/cartest.tscn")


func _on_button_3_pressed() -> void:
	current_car = 0
	forward.show()
	back.hide()
