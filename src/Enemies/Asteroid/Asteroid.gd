extends "res://Enemies/enemies.gd"

export var RotationSpeed : int = 2
var velocity : Vector2 = Vector2.DOWN

func _physics_process(delta):
	rotate((float(RotationSpeed) / 10) * delta)
	position.y = position.y + Speed * delta
	pass
