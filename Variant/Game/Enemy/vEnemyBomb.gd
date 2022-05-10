extends vEnemy

const plBullet2 = preload("res://Variant/Game/Bullet/vBaseEnemyBullet.tscn")

export var speed = 75

const rotateSpeed = 100
const fireRate = 0.2
const spawnPoint = 4
const radius = 50

onready var rotater = $Rotater
onready var shootTimer = $ShootTimer

func _ready():
	var step = 2 * PI / spawnPoint
	
	for i in range(spawnPoint):
		var tempSpawnPoint = Node2D.new()
		var pos = Vector2(radius,0).rotated(step * i)
		tempSpawnPoint.position = pos
		tempSpawnPoint.rotation = pos.angle()
		rotater.add_child(tempSpawnPoint)
		
	shootTimer.wait_time = fireRate
	shootTimer.start()
	
func _process(delta):
	var newRotation = rotater.rotation_degrees + rotateSpeed * delta
	rotater.rotation_degrees = fmod(newRotation, 360)
	
	position.y += speed * delta
	
	


func _on_ShootTimer_timeout():
	for i in rotater.get_children():
		var bulletScene = plBullet2.instance()
		get_tree().get_root().add_child(bulletScene)
		bulletScene.position = i.global_position
		bulletScene.rotation = i.global_rotation
