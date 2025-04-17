extends HSlider


func _on_mouse_exited() -> void:
	self.release_focus()
