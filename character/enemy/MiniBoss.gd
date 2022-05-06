extends Enemy

export var hSpeed := 300

var hDirection: int = 1

func _ready():
	print(get_tree())


func _physics_process(delta):
	position.x += hSpeed * delta * hDirection
	
	var viewRect := get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		hDirection *= -1
