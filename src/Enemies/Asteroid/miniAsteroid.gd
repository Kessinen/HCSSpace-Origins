extends "res://Enemies/enemies.gd"

export var RotationSpeed : int = 2
var rotateDirection : int

func _ready():
	randomize()
	rotate(deg2rad(rand_range(0,90) - 45))
	$sprite.rotate(deg2rad(rand_range(0,360)))
	rotateDirection = round(rand_range(0,1))
	if rotateDirection == 0:
		rotateDirection = -1
	
func _physics_process(delta):
	move_and_slide(Vector2.DOWN.rotated(rotation) * Speed)
	
	$sprite.rotate((float(RotationSpeed) / 10) * delta * rotateDirection)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
