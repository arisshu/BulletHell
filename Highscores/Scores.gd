extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var scoresObject = loadScores("res://Highscores/highscores.json")
	var scoresList = scoresObject["score_list"]
	
	for score in scoresList:
		print(score)
		var score_label = Label.new()
		score_label.text = "test"
		add_child(score_label)


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
