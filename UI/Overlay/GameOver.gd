extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _on_Exit_pressed():
	get_tree().quit()


func _on_Start_pressed():
	SceneManager.change_scene("res://Main Scenes/FirstLevel.tscn", {"pattern": "scribbles"})
	GlobalVar.currentLife = 3
	GlobalVar.currentScore = 0
	queue_free()


func _on_Start2_pressed():
	SceneManager.change_scene("res://Menu/Main Menu.tscn", {"pattern": "scribbles"})
	queue_free()
