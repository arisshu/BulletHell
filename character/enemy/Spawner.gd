extends Node2D

var preloadedEnemies := [
	preload("res://character/enemy/Enemy.tscn"),
	preload("res://character/enemy/EnemyFast.tscn"),
	preload("res://character/enemy/EnemySine.tscn"),
	preload("res://character/enemy/ShootEnemy.tscn")
]

onready var spawnTimer := $SpawnTimer

var dict
export (int, 0, 4) var enemy = 1
export var spawnerSpeed = 100
export var enemySpeed = 300
export var enemyHealth = 5
export var amount = 1
export (float, 1, 1000) var sineFrequency = 5
export (float, 1000) var sineAmplitude = 300
export (int, -1, 1) var sineDirection = 1 
export var spawnInterval: float = 1
	
func _ready():
	var file = File.new()
	file.open("res://LevelFiles/Level1.json", File.READ)
	var text =  file.get_as_text()
	print(text)
	dict = JSON.parse(text)
	file.close()
	spawn_enemies(dict)
	
func _on_SpawnTimer_timeout():
	pass

func spawn_enemies(enemyArray):
	
	pass
