extends vEnemy
class_name vShootEnemy

onready var fireTimer := $FireTimer

#export var fireRate := 1
#export var fireChance := 10
export var speed : int = 100

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	position.y += speed * delta


func _process(delta):
	if fireTimer.is_stopped():
	#var randomChance = randi()%100+1
	#if randomChance <= fireChance:
		fire()
		fireTimer.start(randi()%3+1)
