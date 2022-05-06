extends Node

func _ready():
	Signals.connect("on_scoreboard_display", self, "_on_scoreboard_display")

func _displayScoreAndMoveOn():
	print("called")
