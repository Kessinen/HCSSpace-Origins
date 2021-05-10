extends "res://Levels/levels.gd"


func _ready():
	var player = $Player
	player.position = PlayerStartingPos
	player.z_index = -1
	self.add_child(player)
	
	$EnemySpawner.spawnEnemy("Asteroid",10, Vector2(0,500))
