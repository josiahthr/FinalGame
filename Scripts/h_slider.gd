extends HSlider

@onready var slider := $"."
@onready var Value := $"../Value"

func _on_mouse_exited() -> void:
	self.release_focus()


func _on_drag_ended(value_changed: bool) -> void:
	Value.text = str(slider.value)
	MainMenu.sensitivity = float(slider.value) / 10000
	print(MainMenu.sensitivity)
	print(slider.value)
