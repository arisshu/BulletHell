extends Area2D

const speed = 150
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _process(delta):
	position += transform.x * speed * delta

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
