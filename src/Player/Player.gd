extends KinematicBody2D

export var Name : String = "Player1"
export var HP: int = 10
export var Shield: int = 0

var Score : int = 0

var shipRoF : int = 1
var shipDamage : int = 1
var shipHandling : int = 1
var shipMagnet : int = 1
var shipSpeed : int = 1


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
		velocity = velocity.move_toward(input_vector * shipSpeed*100, shipHandling)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, shipHandling)
	velocity = move_and_slide(velocity)

func fireGuns():
	var rofTimer = $rofTimer
	rofTimer.wait_time = 1 - (float(shipRoF) * 0.099)
	var bullet = plBullet1.instance()
	bullet.bulletDamage = shipDamage
	bullet.position = $Gun.global_position

	if rofTimer.is_stopped():
		get_parent().add_child(bullet)
		rofTimer.start()
	

func takeDamage(amount : int):
	pass
