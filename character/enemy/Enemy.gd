extends Area2D
class_name Enemy


export var speed := 10.0
export var health: int = 20

func _ready():
	$ProgressBar.max_value = health

func _physics_process(delta):
	position.y += speed * delta
	
func _process(delta):
	$ProgressBar.value = health
	
func damage(amount: int):
	health -= amount
	if health <= 0:
		queue_free()

# Remove enemy when leaving the screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		area.damage(1)
		#queue_free()
