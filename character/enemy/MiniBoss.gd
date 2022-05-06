extends Area2D
#class_name Enemy

var plBullet := preload("res://Bullet/EnemyBullet.tscn")
var plExplosion := preload("res://Resources/Animation/NewExplosionEffect.tscn")
var bonusScoreItem := preload("res://Items/BonusScore.tscn")
var explosionScene := preload("res://Resources/Animation/ExplosionScene.tscn")
var stageCompleteScene := preload("res://UI/Overlay/StageComplete.tscn")

var scoreBonus := preload("res://UI/ScoreBonus.tscn")

var plGlobalArray := preload("res://AutoLoads/globalVar.gd")

onready var firingPositions := $MainGun
onready var mainGunTimer := $MainGunTimer

export var speed := 50.0
export var health: int = 20
export var scoreWorth: int = 5000
export var chanceItemDrop: int = 100
export var hDirection: int = 1
export var hSpeed: int = 100

var timerToNext = Timer.new()

func _ready():
	if (GlobalVar.currentStage == 1):
		hSpeed = 100
		health = 100
	elif (GlobalVar.currentStage == 2):
		hSpeed = 200
		health = 150
		
	$ProgressBar.max_value = health
	print("MinoBoss.gd: Current health of boss ", health)
	print("MiniBoss.gd: Current Stage Number ", GlobalVar.currentStage)
	Signals.connect("on_scoreboard_display", self, "_on_scoreboard_display")
		

func _physics_process(delta):
	if (position.y <= 75):
		position.y += speed * delta
	else:
		position.y = position.y
		self.position.x += hSpeed * delta * hDirection
		var viewRect := get_viewport_rect()
		if position.x < viewRect.position.x or position.x > viewRect.end.x:
			hDirection *= -1
	#position.y += speed * delta
	pass
	
func _process(delta):
	$ProgressBar.value = health
	#print("Enemy.gd: Current stage ", GlobalVar.currentStage)
	
	if mainGunTimer.is_stopped():
	#var randomChance = randi()%100+1
	#if randomChance <= fireChance:
		fire()
		mainGunTimer.start(2)
	
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
	if health <= 0:
		return
		
	health -= amount
	
	if health <= 0 :
		#var effect := plExplosion.instance()
		#effect.global_position = global_position
		#get_tree().current_scene.add_child(effect)
		
		var explosionAnim = explosionScene.instance()
		explosionAnim.position = self.global_position
		explosionAnim.scale = Vector2(2.5,2.5)
		explosionAnim.play_animation()
		get_parent().add_child(explosionAnim)
		
		GlobalVar.enemyOnCurrentScreen.erase(self.name)
		Signals.emit_signal("on_score_add", scoreWorth)
		
		#Add score effect
		var bonusItemEffect = scoreBonus.instance()
		bonusItemEffect.global_position = global_position
		bonusItemEffect.setValue(str(scoreWorth))
		get_tree().get_root().add_child(bonusItemEffect)
		
		Signals.emit_signal("on_scoreboard_display")
		#moveToNextStage()
		queue_free()
		return

func dropBonus():
	var bonusItem = bonusScoreItem.instance()
	bonusItem.global_position = global_position
	get_tree().get_root().add_child(bonusItem)


#func selfDestruction():
#	var explosionAnim = explosionScene.instance()
#	explosionAnim.position = self.global_position
#	#explosionAnim.scale = Vector2(rand_range(1,2),rand_range(1,2))
#	explosionAnim.start_anim()
#	get_parent().add_child(explosionAnim)
	
#	Signals.emit_signal("on_score_add", scoreWorth)
	
#	queue_free()

# Remove enemy when leaving the screen
func _on_VisibilityNotifier2D_screen_exited():
	#GlobalVar.enemyOnCurrentScreen.erase(self.name)
	queue_free()


func _on_Boss_area_entered(area):
	if area is Player:
		area.damage(1)

#func _on_VisibilityNotifier2D_screen_entered():	
#	GlobalVar.enemyOnCurrentScreen[self.name] = self


#onready var timerToNext = $TimerToNext
func _on_scoreboard_display():
	var scoreScene = stageCompleteScene.instance()
	#print(get_viewport_rect().size/2)
	scoreScene.offset = Vector2(0,0)
	get_tree().get_root().add_child(scoreScene)
	

