extends Control

var pHealthIcon := preload("res://UI/Life.tscn")

onready var healthContainer := $HealthContainer

func _ready():
	clearLives()
	Signals.connect("on_player_life_changed", self, "_on_player_life_changed")
	

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
