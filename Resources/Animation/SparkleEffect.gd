extends AnimatedSprite

func _ready():
	#print("Summoned?")
	#$AudioStreamPlayer2D.play()
	pass

func start_anim():
	self.playing = true

func _on_AnimatedSprite_animation_finished():
	queue_free()
