extends Node2D

var preloadedEnemies := [
	preload("res://character/enemy/Enemy.tscn"),
	preload("res://character/enemy/EnemyFast.tscn")
]

onready var spawnTimer := $SpawnTime

export var nextSpawnTime := 2

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)


func _on_SpawnTime_timeout():
	var viewRect := get_viewport_rect()
	var xPosition := rand_range(viewRect.position.x, viewRect.end.x)

	var preloadEnemy = preloadedEnemies[randi() % preloadedEnemies.size()]
	var enemy: Enemy = preloadEnemy.instance()
	enemy.position = Vector2(xPosition, 0)
	get_tree().current_scene.add_child(enemy)
	
	spawnTimer.start(nextSpawnTime)
