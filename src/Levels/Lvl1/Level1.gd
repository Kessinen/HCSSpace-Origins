extends "res://Levels/levels.gd"

onready var plstageLost = preload("res://GUI/stageLost.tscn")
onready var hudStageLost = plstageLost.instance()

func _ready():
	$EnemySpawner.spawnEnemy("Asteroid",20, Vector2(0,1000))

func _process(delta):
	checkLevelStatus()

func checkLevelStatus():
	var enemies := get_tree().get_nodes_in_group("Enemies").size()
	var lootOnScreen := get_tree().get_nodes_in_group("Loot").size()
	if enemies + lootOnScreen == 0:
		levelComplete(1)

func _on_Player_IDied():
	get_parent().add_child(hudStageLost)
