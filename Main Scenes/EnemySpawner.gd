extends Node2D

var preloadedEnemies := [
	preload("res://character/enemy/Enemy.tscn"),
	preload("res://character/enemy/EnemyFast.tscn"),
	preload("res://character/enemy/EnemySine.tscn"),
	preload("res://character/enemy/ShootEnemy.tscn")
]

onready var spawnTimer := $SpawnTimer

var dict
var pos: int = 0
var arrayLength: int = 0
var enemyPos: Vector2 = Vector2(0,0)
var time: float = 1
var type: int = 0
var amount: int = 1
var delay: float = 0.3
var enemyLines: int = 1
var offsetX: float = 0.0
var offsetY: float = 0.0
	
func _ready():
	var file = File.new()
	file.open("res://LevelFiles/Level1.json", File.READ)
	var text =  file.get_as_text()
	dict = JSON.parse(text)
	file.close()
	arrayLength = dict.result["SpawnEnemyArray"].size() - 1
	spawn_enemies(dict)
	
func _on_SpawnTimer_timeout():
	place_enemies(type, enemyPos)
	var linesPlaceHolder = enemyLines
	var positions = enemyPos
	
	while linesPlaceHolder > 0:
		print("Line #", linesPlaceHolder)
		place_enemies(type, positions)
		positions += Vector2(offsetX, offsetY)
		linesPlaceHolder -= 1
		
	amount -= 1
	if amount == 0:
		if ! pos >= arrayLength:
			pos += 1
			spawn_enemies(dict)
		else: 
			print("I AM HIT")
			spawnTimer.stop()
			return
	
	spawnTimer.start(delay)
	

func place_enemies(type, position):
	var preloadEnemy = preloadedEnemies[type]
	var myEnemy: Enemy = preloadEnemy.instance()
	myEnemy.position = position
	get_tree().current_scene.add_child(myEnemy)


func spawn_enemies(enemyArray):
	time = float(enemyArray.result["SpawnEnemyArray"][pos]["Time"])
	enemyPos = Vector2(float(enemyArray.result["SpawnEnemyArray"][pos]["LocationX"]), float(enemyArray.result["SpawnEnemyArray"][pos]["LocationY"]))
	type = int(enemyArray.result["SpawnEnemyArray"][pos]["Type"])
	amount = int(enemyArray.result["SpawnEnemyArray"][pos]["Amount"])
	delay = float(enemyArray.result["SpawnEnemyArray"][pos]["Delay"])
	enemyLines = int(enemyArray.result["SpawnEnemyArray"][pos]["EnemyLines"])
	offsetX = float(enemyArray.result["SpawnEnemyArray"][pos]["OffsetX"])
	offsetY = float(enemyArray.result["SpawnEnemyArray"][pos]["OffsetY"])
	print("setting time", time)
	spawnTimer.start(time)
	
