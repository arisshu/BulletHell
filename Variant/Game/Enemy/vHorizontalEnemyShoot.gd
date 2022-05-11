extends vEnemy
#class_name ShootEnemy

onready var fireTimer := $FireTimer
onready var speed = 100

var rng = RandomNumberGenerator.new()

var startPosX

#export var fireRate := 2
#export var fireChance := 5

func _ready():
	startPosX = self.position.x
	if (startPosX > (get_viewport().size.x/2)):
		$Sprite.set_global_rotation_degrees(-90)
		$FiringPositions.set_global_rotation_degrees(-90)
		$FiringPositions.set_position(Vector2(0,-15))

func _process(delta):
	#position.y = -position.y
	if (startPosX <= (get_viewport().size.x/2)):
		position.x += speed * delta
	else:
		position.x -= speed * delta
	#position.y -= speed * delta
	
	if fireTimer.is_stopped():
	#var randomChance = randi()%100+1
	#if randomChance <= fireChance:
			fireScatter()
			#fireTimer.start(randi()%3+0.25)
			fireTimer.start(rng.randf_range(2,4))
