extends "res://Entities/Enemies/Enemy.gd"

export (float) var minRotationSpeed : float = 1
export (float) var maxRotationSpeed : float = 10
var RotationSpeed : float

var rotateDirection : int

onready var minSpeed : float = Speed * 0.5
onready var maxSpeed : float = Speed * 1.5

func _ready():
	randomize()
	RotationSpeed = rand_range(minRotationSpeed, maxRotationSpeed) / 10
	$Sprite.rotation_degrees = rand_range(0,360)
	var rotateDirections := [-1,1]
	rotateDirection = rotateDirections[round(rand_range(0,1))]
	
	Speed = rand_range(minSpeed, maxSpeed)
	
	# Randomize movement direction
	rotate(deg2rad(rand_range(0,90) - 45))
	
func _physics_process(delta):
	move_and_slide(Vector2.DOWN.rotated(rotation) * Speed)
	$Sprite.rotate((float(RotationSpeed) / 10) * delta * rotateDirection)
