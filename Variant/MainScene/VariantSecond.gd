extends Node

var plDisplayLevel := preload("res://UI//Overlay/LevelDisplay.tscn")
var plPauseScreen := preload("res://Menu/Pause.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVar.vCurrentStage = 2
	GlobalVar.powerLevel = 1
	GlobalVar.playingVariant = true
	
	var displaylevelPanel := plDisplayLevel.instance()
	displaylevelPanel.offset = Vector2(0,0)
	get_tree().get_root().add_child(displaylevelPanel)
	
	
	Signals.emit_signal("on_score_add", 0)
	Signals.emit_signal("on_player_life_changed", GlobalVar.vCurrentLife)
	$AudioStreamPlayer2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	SceneManager.change_scene("res://Variant/MainScene/VariantFirst.tscn")
