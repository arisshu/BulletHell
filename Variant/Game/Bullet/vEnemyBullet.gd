extends Area2D

var plBulletEffect := preload("res://Bullet/BulletHitEffect.tscn")

export var speed:float = 120
var direction = Vector2.DOWN

func _ready():
	$AnimatedSprite.playing = true

func _physics_process(delta):
	#position.y += speed * delta
	translate(direction.normalized() * speed * delta)

	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()




func _on_EnemyBullet_area_entered(area):
	if area is vPlayer:
		
		area.damage(1)
		queue_free()

func _on_PlayerBullet_area_entered(area):
	pass
