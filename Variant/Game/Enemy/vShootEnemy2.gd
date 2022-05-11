extends vEnemy
#class_name ShootEnemy

onready var fireTimer := $FireTimer

export var speed : int = 100

func _physics_process(delta):
	position.y += speed * delta

func _process(delta):
	if fireTimer.is_stopped():
	#var randomChance = randi()%100+1
	#if randomChance <= fireChance:
		fireScatter()
		fireTimer.start(randi()%4+2)
