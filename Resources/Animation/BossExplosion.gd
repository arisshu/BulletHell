extends AnimatedSprite

onready var animated_sprite = $"."

var animations = ["default", "default2", "default3"]

# Sound Effect
#onready var deathSoundEffect = AudioStreamPlayer.new()

var index = 0

func _ready():
	#self.add_child(deathSoundEffect)
	#deathSoundEffect.stream = load("res://assets/SoundEffect/death2.wav")
	play_animation()

func play_animation():
	#deathSoundEffect.volume_db = -20
	#deathSoundEffect.play()
	if index < animations.size():
		print(animated_sprite)
		animated_sprite.play(animations[index])
		index += 1
	else:
		queue_free()
		#get_parent().killed_boss()

func _on_BossExplosion_animation_finished():
	play_animation()


