extends Area2D

var plSparkle := preload("res://Resources/Animation/SparkleEffect.tscn")
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
	if area is vPlayer:
		
		var sparkleFX = plSparkle.instance()
		sparkleFX.position = self.global_position
		sparkleFX.scale = Vector2(2.5,2.5)
		sparkleFX.start_anim()
		get_parent().add_child(sparkleFX)
		
		area.incrementPowerLevel()
		queue_free()
