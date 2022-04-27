extends Area2D
class_name Enemy

var plBullet := preload("res://Bullet/EnemyBullet.tscn")
var plExplosion := preload("res://Resources/Animation/DeathEffect.tscn")

var plGlobalArray := preload("res://AutoLoads/globalVar.gd")

onready var firingPositions := $FiringPositions

export var speed := 10.0
export var health: int = 20

func _ready():
	$ProgressBar.max_value = health

func _physics_process(delta):
	position.y += speed * delta
	
func _process(delta):
	$ProgressBar.value = health
	
func fire():
	for child in firingPositions.get_children():
		var bullet := plBullet.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)
		
func damage(amount: int):
	health -= amount
	if health <= 0:
		var effect := plExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		
		GlobalVar.enemyOnCurrentScreen.erase(self.name)
		queue_free()

func selfDestruction():
	var effect := plExplosion.instance()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
	
	queue_free()

# Remove enemy when leaving the screen
func _on_VisibilityNotifier2D_screen_exited():
	GlobalVar.enemyOnCurrentScreen.erase(self.name)
	queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		area.damage(1)

func _on_VisibilityNotifier2D_screen_entered():	
	GlobalVar.enemyOnCurrentScreen[self.name] = self
