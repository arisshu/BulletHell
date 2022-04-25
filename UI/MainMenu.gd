extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()

func show_game_over():
	show_message("Game Over")

func _on_Button_pressed():
	$Start.hide()
	emit_signal("start_game")
