extends Node

var plAsteroid = preload("res://Entities/Enemies/Asteroid/Asteroid.tscn")

func spawnEnemy(enemyType, Amount : int = 1):
	var spawnMargin : int = 80
	randomize()
	var enemies = []
	match enemyType:
		"Asteroid":
			for i in range(Amount):
				var enemy = plAsteroid.instance()
				var spawnpoint = rand_range(spawnMargin,get_viewport().get_visible_rect().size.x - spawnMargin)

				enemy.position.x = spawnpoint
				enemy.position.y = -50
				enemies.append(enemy)
		"Gunship":
			pass
			
	for enemy in enemies:
		var randDelay := rand_range(0,3)
		add_child(enemy)
		yield(get_tree().create_timer(randDelay),"timeout")
