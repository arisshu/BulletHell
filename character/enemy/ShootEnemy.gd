extends Enemy

onready var fireTimer := $FireTimer

export var fireRate := 1
export var fireChance := 10

func _process(delta):
	if fireTimer.is_stopped():
		var randomChance = randi()%100+1
		print(randomChance)
		if randomChance <= fireChance:
			fire()
			fireTimer.start(fireRate)
