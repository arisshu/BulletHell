extends Enemy
class_name SineEnemy

# Limits for the frequency and amplitude
export (float, 1, 1000) var frequency = 5
export (float, 1000) var amplitude = 300
export (int, -1, 1) var direction = 1

var time = 0

func _physics_process(delta):
	time += delta
	var movement = cos(time * frequency)*amplitude 
	position.x += movement * delta * direction
