extends StaticBody3D

signal dead
@onready var damage := $"../../ZombieDamage"
@onready var death := $"../../ZombieDead"
var health = 20
 


func shot():
	print("shot")
	await get_tree().create_timer(.5).timeout 
	damage.play()
	health -= 5
	print("health =", health)
	if health <= 0:
		Groanerstatus.Zalive1 = false
		death.play()
		emit_signal("dead")
