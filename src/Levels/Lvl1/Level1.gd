extends "res://Levels/levels.gd"

var plPlayer = preload("res://Player/Player.tscn")

func _ready():
	var player = plPlayer.instance()
	player.position = PlayerStartingPos
	self.add_child(player)
	
	$EnemySpawner.spawnEnemy("Asteroid",10, Vector2(0,500))
