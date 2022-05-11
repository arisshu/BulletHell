extends vEnemy


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed : int = 100

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	position.y = speed * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
