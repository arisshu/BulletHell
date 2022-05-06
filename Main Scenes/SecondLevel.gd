extends Node

var plDisplayLevel := preload("res://UI//Overlay/LevelDisplay.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.setValue("Level 2")
	GlobalVar.currentStage = 2
	print("SecondLevel.tscn ready: GlobalVar is stage ", GlobalVar.currentStage)
	#$Player.setPowerUp(false)
	Signals.emit_signal("on_score_add", 0)
	Signals.emit_signal("on_player_life_changed", GlobalVar.currentLife)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	SceneManager.change_scene("res://Main Scenes//FirstLevel.tscn")
