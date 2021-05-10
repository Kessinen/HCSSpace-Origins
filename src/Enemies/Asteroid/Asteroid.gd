extends "res://Enemies/enemies.gd"

export var RotationSpeed : int = 2
var velocity : Vector2 = Vector2.DOWN

func _ready():
	randomize()
	rotation_degrees = rand_range(0,360)

func _physics_process(delta):
	rotate((float(RotationSpeed) / 10) * delta)
	position.y = position.y + Speed * delta
