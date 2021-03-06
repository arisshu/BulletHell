extends Area2D
class_name Player

var plBullet := preload("res://Bullet/PlayerBullet.tscn")
var plExplosion := preload("res://Resources/Animation/PlayerExplosion.tscn")
var plGameOver := preload("res://UI//Overlay//GameOver.tscn")

# Sound Effect
onready var itemSoundFX = AudioStreamPlayer.new()


onready var firingPositions := $FiringPositions
onready var powerupPosition := $PowerUp1
onready var fireDelayTimer := $FireDelayTimer
onready var invulTimer := $InvulTimer

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

var powerUp = false


func _ready():
	self.add_child(itemSoundFX)
	itemSoundFX.stream = load("res://Resources/SoundFX/powerup.wav")
	itemSoundFX.volume_db = -20
	
	
	
	invulTimer.start(invulTime)
	#print(GlobalVar.currentLife)
	anim.play("New Anim")
	Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)


##########################################
#
#  Everytime player shoot, this will constantly firing
#
########################################
func _process(delta):
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		
		fireDelayTimer.start(fireDelay)
		for child in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)
		if powerUp:
			for child2 in powerupPosition.get_children():
				var bullet2 := plBullet.instance()
				bullet2.global_position = child2.global_position
				get_tree().current_scene.add_child(bullet2)

##########################################
#
#  Same as above but for movement
#
########################################
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
	
##########################################
#
#  Whenever playing take damage this will fire
#
##########################################
func damage(amount: int):
	Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)

##########################################
#
#  Fired when lose health
#
##########################################
	
	if invulTimer.is_stopped():
		GlobalVar.currentLife -= amount
		Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)
		
		invulTimer.start(invulTime)
		anim.play("New Anim")
		
##########################################
#
#  Fired when no more health
#
##########################################
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
		
		
##########################################
#
#  When player get a health pack, this will fired
#
##########################################
func heal(amount: int):
	#SFX
	itemSoundFX.play()
	
	GlobalVar.currentLife += amount
	
	Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)
	
##########################################
#
#  When player get moregun item, this will fired
#
##########################################	
func setPowerUp(value):
	#SFX
	itemSoundFX.play()
	
	powerUp = value
	
func addBonusScore(value):
	itemSoundFX.play()
	
	Signals.emit_signal("on_score_add", value)
	GlobalVar.currentScore += value	
	
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
	invulTimer.start(invulTime)
