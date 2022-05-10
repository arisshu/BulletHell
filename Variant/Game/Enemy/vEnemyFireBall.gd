extends vEnemy

var plSpiral := preload("res://Variant/Game/Bullet/vEnemySpiralBullet.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 50
export var rotateSpeed = 100
export var bulletFireRate : float = 0.5
export var bulletSpawnPoint : int = 4
export var radiusSpawnBullet : int = 50
export var emitterSpeed : float = 100.0

onready var fireTimer = $Timer
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	position.y += speed * delta

func _process(delta):
	if fireTimer.is_stopped():
		print("Shoot a fireball")
	#var randomChance = randi()%100+1
	#if randomChance <= fireChance:
		shootFireball()
		fireTimer.start(randi()%5+1)
		
func shootFireball():
	for child in firingPositions.get_children():
		var bullet := plSpiral.instance()
		bullet.init(rotateSpeed, bulletFireRate, bulletSpawnPoint, radiusSpawnBullet, emitterSpeed)
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)
