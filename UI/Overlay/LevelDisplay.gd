extends CanvasLayer

onready var timer = $Timer

func _ready():
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	timer.start()
	
func timeout():
	queue_free()
	
func setValue(value):
	$level.text = value
	
