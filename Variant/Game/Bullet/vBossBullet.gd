extends Area2D

var direction : Vector2 = Vector2.ZERO
var velocity : float = 0.0

func _ready():
	$AnimatedSprite.playing = true

func _process(delta : float) -> void:
	global_position += direction * velocity * delta
	#position.y -= velocity * delta


func init(pos : Vector2, dir : Vector2, velo : float, distance : float) -> void:
	direction = dir
	velocity = velo
	
	rotation = direction.angle()
	
	global_position = pos + direction * distance


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_BossBullet_area_entered(area):
	if area is vPlayer:
		area.damage(1)
		queue_free()
