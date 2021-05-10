extends KinematicBody2D

export var HP : int = 10
export var Shields : int = 0
export var Loot : int = 0
export var Speed : int = 0

func takeDamage(amount):
	HP -= amount
	if HP <= 0:
		die()
	print("Damage taken ", amount, " HP left ", HP)

func die():
	queue_free()
