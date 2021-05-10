extends KinematicBody2D

export var Name : String = "Player1"

var Score : int = 0

onready var playerStats = get_node("/root/playerStats")

var velocity = Vector2.ZERO

onready var plBullet1 = preload("res://Bullets/Player/Bullet1.tscn")

func _physics_process(delta):
	
	moveShip()
	
	if Input.is_action_pressed("shoot"):
		fireGuns()

func moveShip():
	var input_vector : Vector2
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * playerStats.shipSpeed*100, playerStats.shipHandling*1.5)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, playerStats.shipHandling)
	velocity = move_and_slide(velocity)

func fireGuns():
	var rofTimer = $rofTimer
	rofTimer.wait_time = 1 - (float(playerStats.shipRoF) * 0.099)
	var bullet = plBullet1.instance()
	bullet.position = $Gun.global_position

	if rofTimer.is_stopped():
		get_parent().add_child(bullet)
		rofTimer.start()

func takeDamage(amount : int):
	pass

func _on_Magnet_body_entered(body):
	if body.is_in_group("Loot"):
		body.queue_free()
