extends Enemy
class_name ShootEnemy

onready var fireTimer := $FireTimer

#export var fireRate := 1
#export var fireChance := 10

func _process(delta):
	if fireTimer.is_stopped():
	#var randomChance = randi()%100+1
	#if randomChance <= fireChance:
			fire()
			fireTimer.start(randi()%3+1)
