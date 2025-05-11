extends Area3D

@export var damage_per_second: int = 5
@onready var damage_timer := $"../../Timer"
var player_in_area = null

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	damage_timer.timeout.connect(_on_damage_tick)

func _on_body_entered(body):
	if body.has_method("apply_toxic_damage"):
		player_in_area = body
		damage_timer.start()

func _on_body_exited(body):
	if body == player_in_area:
		damage_timer.stop()
		player_in_area = null

func _on_damage_tick():
	if player_in_area and player_in_area.has_method("apply_toxic_damage"):
		player_in_area.apply_toxic_damage(damage_per_second)
