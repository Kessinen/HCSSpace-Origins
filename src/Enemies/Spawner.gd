extends Node

var plAsteroid = preload("res://Enemies/Asteroid/Asteroid.tscn")

func spawnEnemy(enemyType, Amount : int = 1):
	var spawnMargin : int = 80
	randomize()
	var enemies = []
	match enemyType:
		"Asteroid":
			for i in range(Amount):
				var enemy = plAsteroid.instance()
				enemy.position.x = rand_range(spawnMargin,get_viewport().size.x - spawnMargin)
				enemy.position.y = -50
				enemies.append(enemy)
			
	for enemy in enemies:
		var randDelay := rand_range(0,3)
		add_child(enemy)
		yield(get_tree().create_timer(randDelay),"timeout")
