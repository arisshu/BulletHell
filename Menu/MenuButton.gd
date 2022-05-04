tool
extends TextureButton

export(String) var text = "Text Button"
export(int) var arrowMarginFromCenter = 100

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

func hide_arrows():
	for arrow in [$leftPlane, $rightPlane]:
		arrow.visible = false


func _on_TextureButton_focus_entered():
	show_arrows()


func _on_TextureButton_focus_exited():
	hide_arrows()


func _on_TextureButton_mouse_entered():
	grab_focus()

