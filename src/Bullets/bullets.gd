extends Area2D

onready var playerStats = get_node("/root/playerStats").playerData

export var bulletDamage : int
export var bulletSpeed : int = 200
export var playerBullet : bool = true


func _ready():
	bulletDamage = playerStats["shipDamage"]
