extends "res://Enemies/enemies.gd"

func _ready():
	randomize()
	rotate(deg2rad(rand_range(0,90) - 45))
	
func _physics_process(delta):
	move_and_slide(Vector2.DOWN.rotated(rotation) * Speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
