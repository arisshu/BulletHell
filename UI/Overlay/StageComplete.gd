tool
extends CanvasLayer

export (String) var finalMsg = "Congrats!"
export (String) var nextLevelMsg = "Stage clear!"

onready var timer = $Timer

func _ready():	
	if (GlobalVar.currentStage == 2):
		$stageClearMsg.bbcode_text = "[center][example freq=1.5][color=yellow] %s [/color][/example][/center]" % finalMsg
	else:
		$stageClearMsg.bbcode_text = "[center][example freq=1.5][color=yellow] %s [/color][/example][/center]" % nextLevelMsg
		
	$VBoxContainer/VBoxContainer/HS.text = "Highscore: " + str(GlobalVar.currentScore)
	timer.connect("timeout", self, "timeout")
	#add_child(timer)
	timer.start()
	
func timeout():
	if (GlobalVar.currentStage == 1):
		SceneManager.change_scene("res://Main Scenes//SecondLevel.tscn")
	elif (GlobalVar.currentStage == 2):
		SceneManager.change_scene("res://Menu//Main Menu.tscn")
		
		var scoresObject = loadScores("res://Highscores/highscores.json")
		var listOfScores = scoresObject["score_list"]
		listOfScores.append(GlobalVar.currentScore)
		listOfScores.sort()
		listOfScores.invert()
		var newScores = { "score_list": listOfScores}
		print(newScores)
		save("res://Highscores/highscores.json", newScores)
		
	queue_free()



func save(var path: String, var object):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_line(to_json(object))
	file.close()
	pass
	
func loadScores(var path: String) -> Dictionary:
	var file = File.new()
	file.open(path, File.READ)
	var text =  file.get_as_text()
	var dict = JSON.parse(text)
	file.close()
	return dict.result
