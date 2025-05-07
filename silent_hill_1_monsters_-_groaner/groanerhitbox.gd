extends StaticBody3D

signal dead

var health = 15
 


func shot():
	print("shot")
	health -= 5
	print("health =", health)
	if health <= 0:
		Groanerstatus.alive = false
		emit_signal("dead")
