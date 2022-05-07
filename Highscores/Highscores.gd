extends Node



func _ready():
	$VBoxContainer/BackButton.grab_focus()



func _on_BackButton_pressed():
	SceneManager.change_scene("res://Menu/Main Menu.tscn", {"pattern": "scribbles"})
