extends Control

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	get_tree().change_scene("res://Main Scenes/FirstLevel.tscn")


func _on_Quit_pressed():
	get_tree().quit()
