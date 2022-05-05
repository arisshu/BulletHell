extends Control

var pHealthIcon := preload("res://UI/Life.tscn")

onready var healthContainer := $HealthContainer
onready var scoreLabel := $Score

var score: int = 0

func _ready():
	clearLives()
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	Signals.connect("on_score_add", self, "_on_score_add")
	

func clearLives():
	for child in healthContainer.get_children():
		healthContainer.remove_child(child)
		child.queue_free()
		
func setLives(lives: int):
	clearLives()
	
	for i in range(lives):
		healthContainer.add_child(pHealthIcon.instance())

func _on_player_life_changed(life: int):
	setLives(life)

func _on_score_add(amount: int):
	GlobalVar.currentScore += amount
	scoreLabel.text = str(GlobalVar.currentScore)

func _on_Timer_timeout():
	pass # Replace with function body.
