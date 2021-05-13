extends KinematicBody2D

export var HPBase : int = 3
export var Shields : int = 0
export var Loot : int = 0
export var Speed : int = 30
export var enemyLevel : int = 1

var HP = HPBase * enemyLevel

var plLoot = preload("res://Loot/Loot.tscn")

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
	var loot = plLoot.instance()
	loot.lootValue = enemyLevel * 10
	loot.position = global_position
	loot.position.x = clamp(loot.position.x,10,get_viewport().size.x-10)
	loot.position.y = clamp(loot.position.y,10,get_viewport().size.y-10)
	get_parent().call_deferred("add_child",loot)

func die():
	spawnLoot()
	queue_free()
