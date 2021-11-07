extends "res://Levels/levels.gd"

func _ready():
	$EnemySpawner.spawnEnemy("Asteroid",20)
	MusicController.changeMusic("Stage1")
	
func _process(delta):
	checkLevelStatus()

func checkLevelStatus():
	var enemies := get_tree().get_nodes_in_group("Enemies").size()
	var lootOnScreen := get_tree().get_nodes_in_group("Loot").size()
	if enemies + lootOnScreen == 0:
		levelComplete()

func _on_Player_IDied():
	get_parent().add_child(hudStageLost)
