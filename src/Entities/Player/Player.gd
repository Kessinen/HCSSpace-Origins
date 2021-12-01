extends KinematicBody2D

export var Name : String = "Player1"

var Score : int = 0
onready var playerStats = get_node("/root/playerStats").playerData
onready var statsData = statData.stats

var curHP : int
var velocity = Vector2.ZERO
var noOfGuns : int = 1

onready var rofTimer = $rofTimer
onready var plBullet1 = preload("res://Bullets/Player/Bullet1.tscn")
onready var statemachine = $AnimationTree.get("parameters/playback")

signal lootChanged(newValue)
signal hpChanged(newValue)
signal IDied()

func _ready():
	curHP = statsData["armor"][str(playerStats["armor"])]["hull"]
	rofTimer.wait_time = statsData["weapons"][str(playerStats["weapons"])]["rof"]
	if playerStats["skill1"]:
		$Guns/Gun1.position.x = -20
		noOfGuns = 2
	$Magnet/CollisionShape2D.shape.radius = statsData["utilities"][str(playerStats["utilities"])]["magnetRadius"]

func _physics_process(_delta):
	moveShip()
	if Input.is_action_pressed("shoot"):
		fireGuns()
	
func moveShip():
	var handling = statsData["engines"][str(playerStats["engines"])]["handling"]
	var speed = statsData["engines"][str(playerStats["engines"])]["speed"]
	var input_vector : Vector2
	
	if Input.is_action_pressed("move_up"):
		statemachine.travel("Accelerate")
	elif Input.is_action_pressed("move_down"):
		statemachine.travel("Deaccelerate")
	else:
		statemachine.travel("Idle")

	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, handling)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, handling)

	velocity = move_and_slide(velocity)

func fireGuns():
	if not rofTimer.is_stopped():
		return
	
	for i in range(1, noOfGuns+1):
		var bullet = plBullet1.instance()
		bullet.position = get_node("Guns/Gun" + str(i)).global_position
		bullet.playerBullet = true
		bullet.bulletDamage = statsData["weapons"][str(playerStats["weapons"])]["damage"]
		get_parent().add_child(bullet)
		$Gun.play()
		
	rofTimer.start()

func takeDamage(amount : int):
	curHP -= amount
	if curHP < 0: 
		curHP = 0
	if curHP <= 0:
		die()
	emit_signal("hpChanged", curHP)

func die():
	Score = 0
	$AnimationPlayer.play("Die")
	emit_signal("IDied")

func _on_Magnet_body_entered(body):
	if body.is_in_group("Loot"):
		Score += body.lootValue
		body.pickUp(global_position)
		emit_signal("lootChanged",Score)

func _exit_tree():
	playerStats["lootAmount"] += Score

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Enemies"):
		takeDamage(body.damageAmount)
