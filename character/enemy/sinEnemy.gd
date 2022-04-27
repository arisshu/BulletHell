extends Enemy
class_name SineEnemy

# Limits for the frequency and amplitude
export (float, 1, 1000) var frequency = 5
export (float, 1000) var amplitude = 300
export (int, -1, 1) var direction = 1

var time = 0
onready var anim = $AnimationPlayer

func _physics_process(delta):
	time += delta
	var movement = cos(time * frequency)*amplitude 
	position.x += movement * delta * direction

func damage(amount: int):
	health -= amount
	if health <= 0:
		var effect := plExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		
		GlobalVar.enemyOnCurrentScreen.erase(self.name)
		queue_free()
