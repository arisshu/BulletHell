tool
extends CanvasLayer

export(String) var text = "Stage Cleared"

onready var timer = $Timer

func _ready():
	$ColorRect/VBoxContainer/HS.text = str(GlobalVar.currentScore)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	timer.start()
	
func timeout():
	queue_free()
