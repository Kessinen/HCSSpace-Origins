extends KinematicBody2D

export var Name : String = "Player1"

var Score : int = 0
onready var origEngineLifetime : float = $Engines/left.lifetime
onready var origEngineVelocity : float =  $Engines/left.process_material.get("initial_velocity")
onready var playerStats = get_node("/root/playerStats").playerData
onready var upgradeMaxValues = get_node("/root/playerStats").upgradeMaxValues

var curHP : int
var velocity = Vector2.ZERO
var noOfGuns = 1

onready var rofTimer = $rofTimer
onready var plBullet1 = preload("res://Bullets/Player/Bullet1.tscn")
onready var plDied = preload("res://GUI/stageLost.tscn")
onready var statemachine = $AnimationTree.get("parameters/playback")

signal lootChanged(newValue)
signal hpChanged(newValue)
signal IDied()

func _ready():
	curHP = int(range_lerp(playerStats["shipHP"],1,10,1,upgradeMaxValues["HP"]))
	rofTimer.wait_time = range_lerp(playerStats["shipRoF"],1,10,1.0,upgradeMaxValues["RoF"])
	if playerStats["skill1"]:
		$Guns/Gun1.position.x = -20
		noOfGuns = 2
	$Magnet/CollisionShape2D.shape.radius = playerStats["shipMagnet"] * 20

func _physics_process(delta):
	moveShip()
	if Input.is_action_pressed("shoot"):
		fireGuns()
	
func moveShip():
	if Input.is_action_pressed("move_up"):
		statemachine.travel("Accelerate")
	elif Input.is_action_pressed("move_down"):
		statemachine.travel("Deaccelerate")
	else:
		statemachine.travel("Idle")
	var input_vector : Vector2
	var accelerate := int(Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	var handling = range_lerp(playerStats["shipHandling"],1,10,1,upgradeMaxValues["Handling"])
	var speed = range_lerp(playerStats["shipSpeed"],1,10,100,upgradeMaxValues["Speed"])
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
		bullet.bulletDamage = range_lerp(playerStats["shipDamage"],1,10,1,upgradeMaxValues["Damage"])
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
