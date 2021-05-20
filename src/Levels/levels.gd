extends StaticBody2D

onready var playerStats = get_node("/root/playerStats").playerData

func levelComplete(level : int):
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
	if playerStats["highestLevel"] <= level:
		playerStats["highestLevel"] = level+1
	pass

func levelDefeat():
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
	pass
