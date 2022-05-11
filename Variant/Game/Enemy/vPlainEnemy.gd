extends vEnemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed : int = 100

func _physics_process(delta):
	position.y += speed * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
