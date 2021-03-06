extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_cancel") and get_tree().current_scene.get_name() != "MainMenu":
		print(get_tree().current_scene.get_name())
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused
	#if !get_tree().paused:
	#	if !visible and Input.is_action_just_pressed("ui_cancel"):
	#		pause()


func _on_Start_pressed():
	get_tree().paused = false
	set_visible(false)
	
func set_visible(isVisible):
	for node in get_children():
		node.visible = isVisible


func _on_Start2_pressed():
	var levelText = get_node("../LevelDisplayLayer")
	if (is_instance_valid(levelText)):
		levelText.timeout()
#	
	#print(levelText)
	get_tree().paused = false
	SceneManager.change_scene("res://Menu//Main Menu.tscn", {"pattern": "scribbles"})
	set_visible(false)
