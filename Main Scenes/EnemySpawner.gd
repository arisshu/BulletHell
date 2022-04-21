extends Node2D

var preloadedEnemies := [
	preload("res://character/enemy/Enemy.tscn"),
	preload("res://character/enemy/EnemyFast.tscn")
]
export (int, 0, 4) var enemy = 0
export var speed = 100

func _physics_process(delta):
	position.y += speed * delta

func _on_VisibilityNotifier2D_screen_entered():
	var preloadEnemy = preloadedEnemies[enemy]
	var enemy: Enemy = preloadEnemy.instance()
	enemy.position = Vector2(global_position.x, 0)
	get_tree().current_scene.add_child(enemy)
	
	queue_free()

