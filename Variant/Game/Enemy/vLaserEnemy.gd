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
var locked = true
var atLeft = false

func _ready():
	activateLaser(true)
	rng.randomize()
	#print(self.position.x, get_viewport().size.x/2)
	print("Self current posX: ", self.position.x)
	if (self.position.x <= get_viewport().size.x/2):
		atLeft = false
		randomPosXToMove = rng.randf_range(self.position.x, get_viewport().size.x/2)
		print("randomPosXToMove: ", randomPosXToMove)
	else:
		atLeft = true
		randomPosXToMove = rng.randf_range(get_viewport().size.x/2 + self.position.x, get_viewport().size.x)
		print("else branch randomPosXToMove: ", randomPosXToMove)
		
	

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	
	if (position.y <= 250 and locked): #Go down
		#print("Going down")
		position.y += speed * delta
	else: #Do something else once reach threshold
		position.y = position.y
		locked = false
		if (self.position.x <= randomPosXToMove):
			position.x += delta * speed
		else:
			position.y += speed * delta
		#if (self.position.x <= viewRect.size.x/2):
			
		#self.position.x += hSpeed * delta * hDirection
		#var viewRect := get_viewport_rect()
		#if position.x < viewRect.position.x or position.x > viewRect.end.x:
			#hDirection *= -1
	#position.y += speed * delta
	#print("Enemy.gd: Current stage ", GlobalVar.currentStage)
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LaserHitBox_area_entered(area):
	if area is vPlayer:
		print("SD")
		area.damage(1)

func activateLaser(value):
	if value:
		laserHitBox.show()
		laserCollisionBox.disabled = false
	else:
		laserHitBox.hide()
		laserCollisionBox.disabled = true
