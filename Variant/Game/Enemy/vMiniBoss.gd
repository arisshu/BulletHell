extends Area2D
#class_name Enemy

var plBullet := preload("res://Variant/Game/Bullet/vEnemySpiralBullet.tscn")
var plBossBullet := preload("res://Variant/Game/Bullet/vBossBullet.tscn")
#var plExplosion := preload("res://Resources/Animation/NewExplosionEffect.tscn")
var bonusScoreItem := preload("res://Items/BonusScore.tscn")
var explosionScene := preload("res://Resources/Animation/ExplosionScene.tscn")
var stageCompleteScene := preload("res://UI/Overlay/StageComplete.tscn")

var rotateSpeed = 100
var bulletFireRate : float = 0.1
var bulletSpawnPoint : int = 4
var radiusSpawnBullet : int = 30
var emitterSpeed : float = 50.0

export var Projectile : PackedScene = null
export (int, 1, 10) var projectiles : int = 1
export (float, 0.0, 180.0) var shooting_angle : float = 30.0
export (float, 100.0, 1000.0) var projectile_velocity : float = 500.0
export (float, 32.0, 128.0) var projectile_distance : float = 32.0

onready var Target = get_node("../Player2")
var shooting_direction : Vector2 = Vector2.ZERO

var scoreBonus := preload("res://UI/ScoreBonus.tscn")

var plGlobalArray := preload("res://AutoLoads/globalVar.gd")

onready var firingPositions := $MainGun
onready var mainGunTimer := $MainGunTimer
onready var secondaryGunTimer := $SecondaryGunTimer

export var speed := 50.0
export var health: int = 150
export var scoreWorth: int = 5000
export var chanceItemDrop: int = 100
export var hDirection: int = 1
export var hSpeed: int = 100

export var mainGunFireRate: float = 6.89
export var secondaryFireRate: float = 2.25

var timerToNext = Timer.new()



func _ready():
	print("What is target? ", Target)
	shooting_angle = deg2rad(shooting_angle)
	
	if (GlobalVar.vCurrentStage == 2 or GlobalVar.currentStage == 2):
		hSpeed = hSpeed * 2
		health = health * 1.75
		
	$ProgressBar.max_value = health
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
	if (is_instance_valid(Target)):
		shooting_direction = global_position.direction_to(Target.global_position)
	
	if mainGunTimer.is_stopped():
		fire()
		mainGunTimer.start(mainGunFireRate)
		
	if (secondaryGunTimer.is_stopped()):
		shoot()
		secondaryGunTimer.start(secondaryFireRate)
	
func fire():
	for child in firingPositions.get_children():
		var bullet := plBullet.instance()
		bullet.init(rotateSpeed, bulletFireRate, bulletSpawnPoint, radiusSpawnBullet, emitterSpeed)
		bullet.global_position = child.global_position
		get_tree().current_scene.add_child(bullet)

		
func damage(amount: int):
	$HurtSound.play()
	
	if health <= 0:
		return
		
	health -= amount
	
	if health <= 0 :
		
		#Upon boss die set invulnerable to player immediately to prevent game over and congrat scene pop up
		Target.startInvulnerable()
		
		var explosionAnim = explosionScene.instance()
		explosionAnim.position = self.global_position
		explosionAnim.scale = Vector2(2.5,2.5)
		explosionAnim.start_anim()
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

#func dropBonus():
#	var bonusItem = bonusScoreItem.instance()
#	bonusItem.global_position = global_position
#	get_tree().get_root().add_child(bonusItem)


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
	if area is Player and is_instance_valid(area):
		area.damage(1)


#onready var timerToNext = $TimerToNext
func _on_scoreboard_display():
	var scoreScene = stageCompleteScene.instance()
	#print(get_viewport_rect().size/2)
	scoreScene.offset = Vector2(0,0)
	get_tree().get_root().add_child(scoreScene)
	

func spawnBullet(angle : float = 0.0) -> void:
	var bullet = Projectile.instance()
	bullet.init(global_position, shooting_direction.rotated(angle), projectile_velocity, projectile_distance)
	get_parent().add_child(bullet)
	
func shoot() -> void:
	if (GlobalVar.vCurrentStage == 1):
		projectiles = 3
	else:
		projectiles = 5
		
	if projectiles == 1:
		spawnBullet()
		return
		
	var stepAngle = shooting_angle / (projectiles - 1)
	
	for i in projectiles:
		spawnBullet(-shooting_angle / 2.0 + stepAngle * i)
