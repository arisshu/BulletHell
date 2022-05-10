extends vEnemy

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var laserHitBox = $LaserHitBox
onready var laserCollisionBox = $LaserHitBox/CollisionShape2D

var viewRect := get_viewport()
var rng = RandomNumberGenerator.new()

var targetPosY = 0
var randomPosXToMove = 0
var targetPosXThreshhold = 200
export var widthBorderLaser = 100
export var waitTime = 1
var locked = true
var atRight = false

func _ready():
	
	#Laser indicator turn off on spawn
	$AnimatedSprite.playing = false
	$AnimatedSprite.visible = false
	activateLaser(false)
	
	
	rng.randomize()
	#print(self.position.x, get_viewport().size.x/2)
	print("Self current posX: ", self.position.x)
	targetPosY = rng.randf_range(120, get_viewport().size.y/2)
	if (self.position.x <= get_viewport().size.x/2):
		atRight = false
		randomPosXToMove = rng.randf_range(self.position.x, get_viewport().size.x - widthBorderLaser)
		print("randomPosXToMove: ", randomPosXToMove)
	else:
		atRight = true
		randomPosXToMove = rng.randf_range(widthBorderLaser, get_viewport().size.x/2)
		#print("else branch size.x minus position.x: ", get_viewport().size.x-self.position.x)
		print("else branch randomPosXToMove: ", randomPosXToMove)
		
	
var enemyBehaviorStage = 1
var delayTime = waitTime
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if (enemyBehaviorStage == 1):
		if (position.y <= targetPosY and locked): #Go down
			#print("Going down")
			position.y += speed * delta
		else:
			enemyBehaviorStage += 1
			delayTime = waitTime
			$AnimatedSprite.playing = true
			$AnimatedSprite.visible = true
	elif(enemyBehaviorStage == 2):
		delayTime -= delta
		if delayTime < 0:
			position.y = position.y
			activateLaser(true)
			locked = false
			if (self.position.x <= randomPosXToMove and !atRight):
				position.x += delta * speed
				speed = 170
			elif (self.position.x >= randomPosXToMove and atRight):
				position.x -= delta * speed
				speed = 170
			else:
				$AnimatedSprite.playing = false
				$AnimatedSprite.visible = false
				position.y += speed * delta
				activateLaser(false)
			
			
	#else: #Do something else once reach threshold
	#	position.y = position.y
	#	activateLaser(true)
	#	locked = false
	#	if (self.position.x <= randomPosXToMove and !atRight):
	#		position.x += delta * speed
	#	elif (self.position.x >= randomPosXToMove and atRight):
	#		position.x -= delta * speed
	#	else:
	#		position.y += speed * delta
	#		activateLaser(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LaserHitBox_area_entered(area):
	if area is vPlayer:
		#print("SD")
		area.damage(1)

func activateLaser(value):
	if value:
		laserHitBox.show()
		laserCollisionBox.disabled = false
	else:
		laserHitBox.hide()
		laserCollisionBox.disabled = true
