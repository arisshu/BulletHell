extends Enemy
class_name ShootEnemy

onready var fireTimer := $FireTimer

export var fireRate := 2
export var fireChance := 5

func _process(delta):
	if fireTimer.is_stopped():
		var randomChance = randi()%100+1
		if randomChance <= fireChance:
			fireScatter()
			fireTimer.start(fireRate)
