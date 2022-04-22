extends Node2D

var preloadedEnemies := [
	preload("res://character/enemy/Enemy.tscn"),
	preload("res://character/enemy/EnemyFast.tscn"),
	preload("res://character/enemy/EnemySine.tscn")
]
onready var spawnTimer := $SpawnTimer

export (int, 0, 4) var enemy = 0
export var spawnerSpeed = 100
export var enemySpeed = 300
export var enemyHealth = 5
export var amount = 1
export (float, 1, 1000) var sineFrequency = 5
export (float, 1000) var sineAmplitude = 300
export (int, -1, 1) var sineDirection = 1 
export var spawnInterval: float = 1




func _physics_process(delta):
	position.y += spawnerSpeed * delta

func _on_VisibilityNotifier2D_screen_entered():
	spawnerSpeed = 0
	spawnTimer.start(spawnInterval)
	

func _on_SpawnTimer_timeout():
	var preloadEnemy = preloadedEnemies[enemy]
	var myEnemy: Enemy = preloadEnemy.instance()
	myEnemy.speed = enemySpeed
	myEnemy.health = enemyHealth
	if enemy == 2:
		myEnemy.direction = sineDirection
		myEnemy.amplitude = sineAmplitude
		myEnemy.frequency = sineFrequency
	if amount == 0:
		queue_free()
		
	myEnemy.position = Vector2(global_position.x, 0)
	get_tree().current_scene.add_child(myEnemy)
	amount -= 1
	spawnTimer.start(spawnInterval)
