extends Node

var plDisplayLevel := preload("res://UI//Overlay/LevelDisplay.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.setValue("Level 2")
	$Player.setPowerUp(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
