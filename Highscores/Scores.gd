extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var scoresObject = loadScores("res://Highscores/highscores.json")
	var scoresList = scoresObject["score_list"]
	
	for score in scoresList.size():
		var place = str(score + 1)
		var placeScore = str(scoresList[score])
		var mc = MarginContainer.new()
		mc.add_constant_override("margin_left", 60)
		var score_label = Label.new()
		score_label.set_text(str(place, ". ", placeScore))
		score_label.add_font_override("font", load("res://Highscores/Font.tres"))
		mc.add_child(score_label)
		add_child(mc)
		if score > 8:
			break


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func loadScores(var path: String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var text =  file.get_as_text()
	var dict = JSON.parse(text)
	file.close()
	return dict.result
