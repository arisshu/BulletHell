extends Camera2D

export var shakeBase := 1.0
export var shakeDampening := 0.075

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var shakeAmount := 0.0

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if shakeAmount > 0:
		position.x = rand_range(-shakeBase, shakeBase) * shakeAmount
		position.y = rand_range(-shakeBase, shakeBase) * shakeAmount
		shakeAmount = lerp(shakeAmount, 0.0, shakeDampening)
		self._set_current(true)
	else:
		position = Vector2(0,0)
		self._set_current(false)
		
func shake(mag: float):
	shakeAmount += mag


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
