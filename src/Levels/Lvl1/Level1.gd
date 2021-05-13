extends "res://Levels/levels.gd"

func _ready():
	var player = $Player
	player.position = PlayerStartingPos
	player.z_index = -1
	
	$EnemySpawner.spawnEnemy("Asteroid",10, Vector2(0,500))

func _process(delta):
	checkLevelStatus()

func checkLevelStatus():
	var enemies := get_tree().get_nodes_in_group("Enemies").size()
	var lootOnScreen := get_tree().get_nodes_in_group("Loot").size()
	if enemies + lootOnScreen == 0:
		levelComplete(1)
