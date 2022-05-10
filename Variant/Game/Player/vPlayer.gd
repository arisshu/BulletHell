extends Area2D
class_name vPlayer

var plBullet := preload("res://Variant/Game/Bullet/vPlayerBullet.tscn")
var plExplosion := preload("res://Resources/Animation/PlayerExplosion.tscn")
var plGameOver := preload("res://UI//Overlay//GameOver.tscn")


onready var firingPositions := $FiringPositions
onready var powerupPosition := $PowerUp1
onready var fireDelayTimer := $FireDelayTimer
onready var invulTimer := $InvulTimer


export (float, 0.0, 180.0) var shooting_angle : float = 25.0
export (float, 100.0, 1000.0) var projectile_velocity : float = 500.0
export (float, 32.0, 128.0) var projectile_distance : float = 32.0


onready var anim = $AnimationPlayer

onready var deathEvent := $deathEventTimer

# use colon to specify type
export var speed:float = 100.0
export var fireDelay:float = 0.1
#var life = GlobalVar.currentLife
export var invulTime:float = 2
# := is like above except
# godot infers the type on
# the right side
var vel:= Vector2(0,0)
var shooting_direction : Vector2 = Vector2.ZERO

var powerUp = false

func _ready():
	var viewRect := get_viewport_rect()
	shooting_angle = deg2rad(shooting_angle)
	shooting_direction = global_position.direction_to(Vector2(viewRect.size.x/2,0))
	
	invulTimer.start(invulTime)
	#print(GlobalVar.currentLife)
	anim.play("New Anim")
	Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)

func _process(delta):
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		#for child in firingPositions.get_children():
		#	var bullet := plBullet.instance()
		#	bullet.global_position = child.global_position
		#	get_tree().current_scene.add_child(bullet)
		#if powerUp:
		#	for child2 in powerupPosition.get_children():
		#		var bullet2 := plBullet.instance()
		#		bullet2.global_position = child2.global_position
		#		get_tree().current_scene.add_child(bullet2)
		fire()


func _physics_process(delta):
	var dirVec := Vector2(0,0)
	
	if Input.is_action_pressed("moveLeft"):
		dirVec.x = -1
	elif Input.is_action_pressed("moveRight"):
		dirVec.x = 1
	if Input.is_action_pressed("moveUp"):
		dirVec.y = -1
	elif Input.is_action_pressed("moveDown"):
		dirVec.y = 1
	
	vel = dirVec.normalized() * speed
	position += vel * delta	
	
	# Make sure that the player is within the screen.
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)
	
func fire():
	if GlobalVar.powerLevel == 1:
		spawnBullet()
		return
	elif (GlobalVar.powerLevel == 2):
		shooting_angle = deg2rad(5)
	elif (GlobalVar.powerLevel == 3):
		shooting_angle = deg2rad(15)
	elif (GlobalVar.powerLevel == 4):
		shooting_angle = deg2rad(20)
	else:
		shooting_angle = deg2rad(25)
		
	var stepAngle = shooting_angle / (GlobalVar.powerLevel - 1)
	
	for i in GlobalVar.powerLevel:
		spawnBullet(-shooting_angle / 2.0 + stepAngle * i)
	
func spawnBullet(angle : float = 0.0) -> void:
	var bullet = plBullet.instance()
	bullet.init(global_position, shooting_direction.rotated(angle), projectile_velocity, projectile_distance)
	get_parent().add_child(bullet)

func damage(amount: int):
	Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)
	
	if invulTimer.is_stopped():
		GlobalVar.currentLife -= amount
		Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)
		
		invulTimer.start(invulTime)
		anim.play("New Anim")
		
	
	if GlobalVar.currentLife <= 0 and deathEvent.is_stopped():
		Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)
		#Handle animation
		var effect := plExplosion.instance()
		#effect.global_position = global_position
		effect.position = self.global_position
		effect.scale = Vector2(2,2)
		effect.start_anim()
		get_parent().add_child(effect)
		
		var gameOverScene = plGameOver.instance()
		var scoresObject = loadScores("res://Highscores/highscores.json")
		var listOfScores = scoresObject["score_list"]
		listOfScores.append(GlobalVar.currentScore)
		listOfScores.sort()
		listOfScores.invert()
		var newScores = { "score_list": listOfScores}
		print(newScores)
		save("res://Highscores/highscores.json", newScores)
	#print(get_viewport_rect().size/2)
		gameOverScene.offset = Vector2(0,0)
		get_tree().get_root().add_child(gameOverScene)
		
		deathEvent.start(1)
		queue_free()
		
		
	
func heal(amount: int):
	GlobalVar.currentLife += amount
	
	Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)
	
func incrementPowerLevel():
	if (GlobalVar.powerLevel < 5):
		print("Created new timer")
		
		var timer = Timer.new()
		timer.set_wait_time(5)
		timer.set_one_shot(true)
		timer.connect("timeout", self, "timeout")
		add_child(timer)
		timer.start()
		
		#print(timer.get_time_left())
		GlobalVar.powerLevel += 1
	else:
		GlobalVar.powerLevel = GlobalVar.maxPowerLevel

func timeout():
	print("Timer expired")
	GlobalVar.powerLevel -= 1
	
func save(var path: String, var object):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(object))
	file.close()
	pass
	
func loadScores(var path: String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var text =  file.get_as_text()
	var dict = JSON.parse(text)
	file.close()
	return dict.result



func startInvulnerable():
	print("Called")
	invulTimer.start(invulTime)
