extends Node2D

var preloadedItems := [
	preload("res://Items/HealthPack.tscn"),
	preload("res://Items/MoreGun.tscn"),
	preload("res://Items/PlaneDestruction.tscn")
]

onready var itemTimer := $ItemTimer

var dict
var pos: int = 0
var arrayLength: int = 0
var itemPos: Vector2 = Vector2(0,0)
var time: float = 1
var type: int = 0
	
func _ready():
	var file = File.new()
	file.open("res://LevelFiles/Level1Items.json", File.READ)
	var text =  file.get_as_text()
	dict = JSON.parse(text)
	file.close()
	arrayLength = dict.result["SpawnItemArray"].size() - 1
	spawn_items(dict)
	
func _on_ItemTimer_timeout():
	place_items(type, itemPos)
	
	itemTimer.stop()
	if ! pos >= arrayLength:
		pos += 1
		spawn_items(dict)
	else: 
		return
	

func place_items(type, position):
	var preloadItem = preloadedItems[type]
	var myItem = preloadItem.instance()
	myItem.position = position
	get_tree().current_scene.add_child(myItem)


func spawn_items(itemArray):
	time = float(itemArray.result["SpawnItemArray"][pos]["Time"])
	itemPos = Vector2(float(itemArray.result["SpawnItemArray"][pos]["LocationX"]), float(itemArray.result["SpawnItemArray"][pos]["LocationY"]))
	type = int(itemArray.result["SpawnItemArray"][pos]["Type"])
	itemTimer.start(time)
