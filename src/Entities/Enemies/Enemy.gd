extends KinematicBody2D

export (int) var HPBase : int = 3
export (int) var Shields : int = 0
export (int) var maxLoot : int = 10
export (int) var Speed : int = 30
export (int) var enemyLevel : int = 1
export (int) var damageAmount : int = 1
export (int) var RoF : int = 0

export (PackedScene) var psBullet

onready var HP = HPBase * enemyLevel
var rofTimer = Timer.new()

var plLoot = preload("res://Loot/Loot.tscn")

func _ready():
	rofTimer.wait_time = RoF
	rofTimer.one_shot = true
	add_child(rofTimer)

func takeDamage(amount):
	if amount > Shields:
		amount -= Shields
		Shields = 0
	else:
		Shields -= amount
		amount = 0
	HP -= amount
	if HP <= 0:
		die()

func spawnLoot():
	randomize()
	var loot = plLoot.instance()
	loot.lootValue = int(rand_range(maxLoot*0.1, maxLoot) * enemyLevel)
	loot.position = global_position
	loot.position.x = clamp(loot.position.x,10,get_viewport().size.x-10)
	loot.position.y = clamp(loot.position.y,10,get_viewport().size.y-10)
	get_parent().call_deferred("add_child",loot)

func die():
	$AnimationPlayer.play("Die")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
