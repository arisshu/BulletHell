extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles2D.emitting = true
	$Particles2D/Particles2D.emitting = true
	$Particles2D/Particles2D2.emitting = true
	$Particles2D/Particles2D3.emitting = true
	
func _process(delta):
	if !$Particles2D.emitting or !$Particles2D/Particles2D.emitting or !$Particles2D/Particles2D2.emitting or !$Particles2D/Particles2D3.emitting:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
