extends HSlider

@onready var slider := $"."
@onready var Value := $"../Value2"
@export var bus_name: String

var bus_index: float

func _ready() -> void:
	slider.value = MainMenu.volume
	bus_index = AudioServer.get_bus_index("Master")
	value_changed.connect(_on_value_changed)
	Value.text = str(slider.value)
	
func _on_mouse_exited() -> void:
	self.release_focus()


func _on_drag_ended(value_changed: bool) -> void:
	Value.text = str(slider.value)
	MainMenu.volume = slider.value
	print(MainMenu.volume)
	print(slider.value)
	_on_value_changed()

func _on_value_changed():
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(slider.value)
	)
