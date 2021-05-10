extends KinematicBody2D

export var HP : int = 10
export var Shields : int = 0
export var Loot : int = 0
export var Speed : int = 0

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

func die():
	queue_free()
