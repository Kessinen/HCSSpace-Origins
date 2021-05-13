extends StaticBody2D

onready var PlayerStartingPos := Vector2(get_viewport().size.x / 2,get_viewport().size.y - 64)
onready var playerStats = get_node("/root/playerStats")

func levelComplete(level : int):
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
	if playerStats.highestLevel <= level:
		playerStats.highestLevel = level+1
	pass

func levelDefeat():
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
	pass
