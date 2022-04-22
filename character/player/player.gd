extends Area2D
class_name Player

var plBullet := preload("res://Bullet/PlayerBullet.tscn")

onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer
onready var invulTimer := $InvulTimer

onready var anim = $AnimationPlayer


# use colon to specify type
export var speed:float = 100.0
export var fireDelay:float = 0.1
export var life:int = 3
export var invulTime:float = 0.5
# := is like above except
# godot infers the type on
# the right side
var vel:= Vector2(0,0)

func _ready():
	invulTimer.start(invulTime)
	anim.play("New Anim")
	Signals.emit_signal("on_player_life_changed", life)

func _process(delta):
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		for child in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)


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
	
func damage(amount: int):
	life -= amount
	
	Signals.emit_signal("on_player_life_changed", life)
	if !invulTimer.is_stopped():
		return
	
	invulTimer.start(invulTime)
	anim.play("New Anim")
	
	if life <= 0:
		queue_free()
	
