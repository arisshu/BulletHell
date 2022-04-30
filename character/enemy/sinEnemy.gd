extends Enemy
class_name SineEnemy

# Limits for the frequency and amplitude
export (float, 1, 1000) var frequency = 5
export (float, 1000) var amplitude = 300
export (int, -1, 1) var direction = 1

export var scoreWorthy = 50

var time = 0
onready var anim = $AnimationPlayer


func _physics_process(delta):
	time += delta
	var movement = cos(time * frequency)*amplitude 
	position.x += movement * delta * direction

func damage(amount: int):
	health -= amount
	if health <= 0:
		var explosionAnim = explosionScene.instance()
		explosionAnim.position = self.global_position
		#explosionAnim.scale = Vector2(rand_range(1,2),rand_range(1,2))
		explosionAnim.start_anim()
		get_parent().add_child(explosionAnim)
		
		GlobalVar.enemyOnCurrentScreen.erase(self.name)
		Signals.emit_signal("on_score_add", scoreWorthy)
		queue_free()
