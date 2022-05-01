extends Area2D

var scoreBonus := preload("res://UI/ScoreBonus.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed := 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position.y += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Item_area_entered(area):
	if area is Player:
		Signals.emit_signal("on_score_add", 1000)
		
		var bonusItemEffect = scoreBonus.instance()
		bonusItemEffect.global_position = global_position
		bonusItemEffect.setValue(1)
		get_tree().get_root().add_child(bonusItemEffect)
		
		queue_free()