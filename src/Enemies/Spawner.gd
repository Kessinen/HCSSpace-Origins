extends Node

var plAsteroid = preload("res://Enemies/Asteroid/Asteroid.tscn")

func spawnEnemy(enemyType, Amount : int = 1, enemyPosition : Vector2 = Vector2.ZERO):
	randomize()
	var enemies = []
	match enemyType:
		"Asteroid":
			for i in range(Amount):
				var enemy = plAsteroid.instance()
				enemy.position.x = rand_range(20,get_viewport().size.x - 20)
				enemy.position.y = rand_range(enemyPosition.y * -1, -10)
				enemies.append(enemy)
	
	for enemy in enemies:
		get_parent().add_child(enemy)
