extends PathFollow3D


func _process(delta):
	if Groanerstatus.alive == true:
		progress += 2 * delta
	elif Groanerstatus.alive == false:
		progress += 0 * delta
