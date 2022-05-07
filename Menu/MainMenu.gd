extends Node



func _ready():
	$VBoxContainer/VBoxContainer/Start.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	pass # Replace with function body.


func _on_Control_pressed():
	pass # Replace with function body.


func _on_Exit_pressed():
	get_tree().quit()


func _on_Start_pressed():
	SceneManager.change_scene("res://Main Scenes/FirstLevel.tscn", {"pattern": "scribbles"})


func _on_Highscores_pressed():
	SceneManager.change_scene("res://Highscores/Scores.tscn", {"pattern": "scribbles"})
