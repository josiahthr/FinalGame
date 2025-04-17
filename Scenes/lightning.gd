extends DirectionalLight3D

@onready var lightning_light: DirectionalLight3D = $"."
@onready var strike_timer: Timer = $Timer
@onready var ThunderSound: AudioStreamPlayer3D = $ThunderSound

func _ready():
	strike_timer.timeout.connect(_on_strike_timer_timeout)
	
func _on_strike_timer_timeout():
	if randf() < 0.5:
		lightning_light.show()
		ThunderSound.play()
		await get_tree().create_timer(1.2).timeout
		lightning_light.hide()
