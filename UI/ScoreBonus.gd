extends Node2D

var timer = null

var textureList := {
	"0": "res://Textures/Tiles/tile_0019.png",
	"1000": "res://Textures/Tiles/tile_0020.png",
	"2000": "res://Textures/Tiles/tile_0021.png",
	"3000": "res://Textures/Tiles/tile_0022.png",
	"4000": "res://Textures/Tiles/tile_0023.png",
	"5000": "res://Textures/Tiles/tile_0031.png",
	"6000": "res://Textures/Tiles/tile_0032.png",
	"7000": "res://Textures/Tiles/tile_0033.png",
	"8000": "res://Textures/Tiles/tile_0034.png",
	"9000": "res://Textures/Tiles/tile_0034.png",
}



# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(2)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	timer.start()
	
func timeout():
	queue_free()
	
func setValue(value):
	print(textureList[value])
	$HBoxContainer/Head.texture = load((textureList[value]))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
