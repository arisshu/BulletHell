extends Area2D

var direction : Vector2 = Vector2.ZERO
var velocity : float = 9.0

var plBulletEffect := preload("res://Bullet/BulletHitEffect.tscn")

func _ready():
	$AnimatedSprite.playing = true
	$AudioStreamPlayer2D.play()

func _process(delta : float) -> void:
	global_position += direction * velocity * delta


func init(pos : Vector2, dir : Vector2, velo : float, distance : float) -> void:
	direction = dir
	velocity = velo
	
	rotation = direction.angle()
	
	global_position = pos + direction * distance


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	

func _on_PlayerBullet_area_entered(area):
	if area.is_in_group("damagable"):
		var bulletFX := plBulletEffect.instance()
		bulletFX.position = position
		get_parent().add_child(bulletFX)
		
		area.damage(1)
		queue_free()
