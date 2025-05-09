extends Area3D



@export var item_type: String = "armor"
@export var value: int = 100
@onready var pickup_sound := $"../../ItemPickup"
@onready var mainbody := $".."

func _on_body_entered(body):
	if body.has_method("apply_item_pickup"):
		body.apply_item_pickup(item_type, value)
		pickup_sound.play()
		mainbody.queue_free()
