extends Area2D
class_name vEnemy

var plBullet := preload("res://Variant/Game/Bullet/vEnemyBullet.tscn")
var plExplosion := preload("res://Resources/Animation/NewExplosionEffect.tscn")
var bonusScoreItem := preload("res://Variant/Game/Items/vBonusScore.tscn")
var explosionScene := preload("res://Resources/Animation/ExplosionScene.tscn")

var plGlobalArray := preload("res://AutoLoads/globalVar.gd")

onready var firingPositions := $FiringPositions
onready var hurtSoundFX := $HurtSound


#export var speed := 10.0
export var health: int = 20
export var scoreWorth: int = 100
export var chanceItemDrop: int = 100

func _ready():
	print(hurtSoundFX)
	$ProgressBar.max_value = health

#func _physics_process(delta):
#	position.y += speed * delta
	#print("Enemy.gd: Current stage ", GlobalVar.currentStage)
#	pass
	
func _process(delta):
	$ProgressBar.value = health
	
func fire():
	for child in firingPositions.get_children():
		var bullet := plBullet.instance()
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)
		
func fireScatter():
	for child in firingPositions.get_children():
		var bullet := plBullet.instance()
		bullet.direction = child.global_position - global_position
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)
		
func damage(amount: int):
	hurtSoundFX.play()
	
	if health <= 0:
		return
		
	health -= amount
	
	if health <= 0 :
		#var effect := plExplosion.instance()
		#effect.global_position = global_position
		#get_tree().current_scene.add_child(effect)
		
		var explosionAnim = explosionScene.instance()
		explosionAnim.position = self.global_position
		#explosionAnim.scale = Vector2(rand_range(1,2),rand_range(1,2))
		explosionAnim.start_anim()
		get_parent().add_child(explosionAnim)

		
		GlobalVar.enemyOnCurrentScreen.erase(self.name)
		Signals.emit_signal("on_score_add", scoreWorth)
		
		var randomChance = (randi()%100)+1
		if randomChance <= chanceItemDrop:
			dropBonus()
		
		queue_free()
		return

func dropBonus():
	var bonusItem = bonusScoreItem.instance()
	bonusItem.global_position = global_position
	get_tree().get_root().add_child(bonusItem)


func selfDestruction():
	var explosionAnim = explosionScene.instance()
	explosionAnim.position = self.global_position
	#explosionAnim.scale = Vector2(rand_range(1,2),rand_range(1,2))
	explosionAnim.start_anim()
	get_parent().add_child(explosionAnim)
	
	Signals.emit_signal("on_score_add", scoreWorth)
	
	queue_free()

# Remove enemy when leaving the screen
func _on_VisibilityNotifier2D_screen_exited():
	GlobalVar.enemyOnCurrentScreen.erase(self.name)
	queue_free()


func _on_Enemy_area_entered(area):
	if area is vPlayer:
		area.damage(1)

func _on_VisibilityNotifier2D_screen_entered():	
	GlobalVar.enemyOnCurrentScreen[self.name] = self
