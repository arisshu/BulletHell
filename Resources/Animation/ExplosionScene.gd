extends AnimatedSprite

func _ready():
	$AudioStreamPlayer2D.play()

func start_anim():
	self.playing = true

func _on_AnimatedSprite_animation_finished():
	queue_free()
