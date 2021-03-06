tool
extends TextureButton

export(String) var text = "Start Text"
export(int) var arrowMarginFromCenter = 100

onready var selectSound := $selectSound

func _ready():
	setup_text()
	hide_arrows()
	set_focus_mode(true)
	
	
func _process(delta):
	if Engine.editor_hint:
		setup_text()
		show_arrows()
	
func setup_text():
	$RichTextLabel.bbcode_text = "[center] %s [/center]" % [text]
	
func show_arrows():
	for arrow in [$leftPlane, $rightPlane]:
		arrow.visible = true
		arrow.global_position.y = rect_global_position.y + (rect_size.y / 3.0)
		
	var center_x = rect_global_position.x + (rect_size.x / 2)
	$leftPlane.global_position.x = center_x - arrowMarginFromCenter
	$rightPlane.global_position.x = center_x + arrowMarginFromCenter
	
	$RichTextLabel.bbcode_text = "[center][color=yellow] %s [/color][/center]" % [text]

func hide_arrows():
	for arrow in [$leftPlane, $rightPlane]:
		arrow.visible = false
		
	$RichTextLabel.bbcode_text = "[center] %s [/center]" % [text]

func _on_TextureButton_focus_entered():
	show_arrows()
	selectSound.play()
	var getBGNode = get_node("/root/MainMenu/ParallaxBackground2")
	var newBGNode = get_node("/root/MainMenu/vParallaxBackground")
	var menuBackground = self.get_name()
	if (menuBackground == "Start2"):
		if getBGNode.get_child_count() != 0:
			for i in getBGNode.get_children():
				i.visible = false
			for x in newBGNode.get_children():
				x.visible = true
	elif (menuBackground == "Start" or menuBackground == "Highscores" or menuBackground == "Exit"):
		for i in getBGNode.get_children():
			i.visible = true


func _on_TextureButton_focus_exited():
	hide_arrows()


func _on_TextureButton_mouse_entered():
	grab_focus()
