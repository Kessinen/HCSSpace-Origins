extends "res://Entities/Enemies/enemies.gd"

export (float) var minRotationSpeed : float = 1
export (float) var maxRotationSpeed : float = 10

onready var minSpeed : float = Speed * 0.5
onready var maxSpeed : float = Speed * 1.5

var RotationSpeed : float

var velocity : Vector2 = Vector2.DOWN
var rotateDirection := 1
var plAsteroid = preload("res://Entities/Enemies/Asteroid/miniAsteroid.tscn")

func _ready():
	randomize()
	RotationSpeed = rand_range(minRotationSpeed, maxRotationSpeed) / 10
	$sprite.rotation_degrees = rand_range(0,360)
	var rotateDirections := [-1,1]
	rotateDirection = rotateDirections[round(rand_range(0,1))]
	Speed = rand_range(minSpeed, maxSpeed)

func _physics_process(delta):
	$sprite.rotate(RotationSpeed * delta * rotateDirection)
	position.y = position.y + Speed * delta

func die():
	for i in range(enemyLevel * 2):
		spawnChild()
	.die()

func spawnChild():
	var enemy = plAsteroid.instance()
	enemy.position = global_position
	get_parent().call_deferred("add_child", enemy)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
