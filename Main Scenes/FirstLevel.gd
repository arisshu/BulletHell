extends Node

var plDisplayLevel := preload("res://UI//Overlay/LevelDisplay.tscn")
var plPauseScreen := preload("res://Menu/Pause.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control.setValue("Level 1")
	GlobalVar.currentStage = 1
	Signals.emit_signal("on_score_add", 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	SceneManager.change_scene("res://Main Scenes//SecondLevel.tscn")
