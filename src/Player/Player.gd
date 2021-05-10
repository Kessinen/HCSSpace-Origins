extends KinematicBody2D

export var Name : String = "Player1"
export var HP: int = 10
export var Shield: int = 0
export var MaxSpeed : int = 2000
export var MagnetRadius : int = 10
export var Acceleration : int = 10

var Score : int = 0

var velocity = Vector2.ZERO

onready var plBullet1 = preload("res://Bullets/Player/Bullet1.tscn")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var input_vector : Vector2
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MaxSpeed, Acceleration)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Acceleration)
		
	move_and_slide(velocity)
	
func _unhandled_key_input(event):
	
	if event.is_action_pressed("shoot"):
		print("unhandlet")
		fireGuns()

func fireGuns():
	var bullet = plBullet1.instance()
	bullet.position = $Gun.global_position
	get_parent().add_child(bullet)
	

func takeDamage(amount : int):
	pass
