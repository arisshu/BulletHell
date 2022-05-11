extends CanvasLayer

onready var timer = $Timer
onready var instructionPanel := $Instruction

func _ready():
	if (GlobalVar.playingVariant):
		$level.text = "Level " + str(GlobalVar.vCurrentStage)
	else:
		$level.text = "Level " + str(GlobalVar.currentStage)
	if (GlobalVar.currentStage != 1 or GlobalVar.vCurrentStage != 1):
		for i in instructionPanel.get_children():
			i.visible = false

	timer.connect("timeout", self, "timeout")
	#add_child(timer)
	timer.start()
	
func timeout():
	queue_free()

	
