extends KinematicBody2D

onready var playerStats = get_node("/root/playerStats")

export var lootSpeed : int = 20
export var lootValue : int = 1

var attractTarget

func _ready():
	$Magnet/CollisionShape2D.shape.radius = playerStats.shipMagnet * 20

func _physics_process(delta):
	if attractTarget != null:
		var direction = position.direction_to(attractTarget.global_position)
		move_and_collide(direction * lootSpeed * 30 * delta)
	else:
		position.y += lootSpeed * delta

func _on_Magnet_body_entered(body):
	if body.name == "Player":
		attractTarget = body

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
