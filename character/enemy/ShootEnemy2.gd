extends ShootEnemy

export var hSpeed := 10.0

var hDirection: int = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	self.position.x += hSpeed * delta * hDirection
	
	var viewRect := get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		hDirection *= -1
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
