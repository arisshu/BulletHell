extends AnimatedSprite

func _ready():
	pass

func start_anim():
	self.playing = true


func _on_PlayerExplosion_animation_finished():
	queue_free()
