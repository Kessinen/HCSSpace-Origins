extends "res://Enemies/enemies.gd"

export var RotationSpeed : int = 2
var velocity : Vector2 = Vector2.DOWN

var plAsteroid = preload("res://Enemies/Asteroid/miniAsteroid.tscn")

func _ready():
	randomize()
	$sprite.rotation_degrees = rand_range(0,360)

func _physics_process(delta):
	$sprite.rotate((float(RotationSpeed) / 10) * delta)
	position.y = position.y + Speed * delta

func die():
	for i in range(enemyLevel * 2):
		spawnChild()
	queue_free()

func spawnChild():
	var enemy = plAsteroid.instance()
	enemy.position = global_position
	get_parent().call_deferred("add_child", enemy)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
