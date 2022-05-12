extends Node

onready var spawnTimer := $spawnTimer

var plMoreGun := preload("res://Variant/Game/Items/vMoreGun.tscn") 

var nextSpawnTime := 15.0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	spawnTimer.start(rng.randf_range(nextSpawnTime, 30))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_spawnTimer_timeout():
	
	
	var plItem = plMoreGun.instance()
	plItem.position = Vector2(rng.randf_range(50, get_viewport().size.x), 0)
	
	get_tree().current_scene.add_child(plItem)
	
	
	pass # Replace with function body.
