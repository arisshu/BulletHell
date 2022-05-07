tool
extends CanvasLayer

export(String) var text = "Stage Cleared"

onready var timer = $Timer

func _ready():
	$VBoxContainer/VBoxContainer/HS.text = "Highscore: " + str(GlobalVar.currentScore)
	timer.connect("timeout", self, "timeout")
	add_child(timer)
	timer.start()
	
func timeout():
	if (GlobalVar.currentStage == 1):
		SceneManager.change_scene("res://Main Scenes//SecondLevel.tscn")
		print("Change scene to 2")
	elif (GlobalVar.currentStage == 2):
		SceneManager.change_scene("res://Main Scenes//ThirdLevel.tscn")
		print("change scene before crash")
	queue_free()
