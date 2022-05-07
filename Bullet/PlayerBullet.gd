extends Area2D

var plBulletEffect := preload("res://Bullet/BulletHitEffect.tscn")

export var speed:float = 500

func _physics_process(delta):
	position.y -= speed * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

#func _on_Bullet_area_entered(area):
#	pass


func _on_PlayerBullet_area_entered(area):
	if area.is_in_group("damagable"):
		
		var bulletFX := plBulletEffect.instance()
		bulletFX.position = position
		get_parent().add_child(bulletFX)
		
		area.damage(1)
		queue_free()
