extends Node2D

var t := 1.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed := 200.0


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	t += delta
	$Path2D/PathFollow2D.offset = t * speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

