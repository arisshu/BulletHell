extends Camera2D

export var shakeBaseAmt := 1.0
export var shakeDampening := 0.070

var shakeAmt := 3.0


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if shakeAmt > 0:
		position.x = rand_range(-shakeBaseAmt, shakeBaseAmt) * shakeAmt
		position.y = rand_range(-shakeBaseAmt, shakeBaseAmt) * shakeAmt
	else:
		position = Vector2(position.x,position.y)
		
func shake(magnitude: float):
	shakeAmt += magnitude


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
