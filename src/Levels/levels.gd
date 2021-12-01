extends StaticBody2D

export (int) var levelNumber : int = 1
export (int) var completeBonus : int = 0

onready var playerStats = get_node("/root/playerStats").playerData
onready var plstageLost = preload("res://GUI/stageLost.tscn")
onready var hudStageLost = plstageLost.instance()

func _ready():
	$Player.connect("lootChanged", $Gui, "_on_Player_lootChanged")
	$Player.connect("hpChanged", $Gui, "_on_Player_hpChanged")
	$Player.connect("IDied", self, "_on_levelDefeat")
	pass

func levelComplete():
	if playerStats["highestLevel"] <= levelNumber and playerStats["highestLevel"] < 10:
		playerStats["lootAmount"] += completeBonus
		playerStats["highestLevel"] = levelNumber+1
	get_tree().change_scene("res://Menus/LevelSelect.tscn")

func _on_levelDefeat():
	var gameover = plstageLost.instance()
	get_parent().add_child(gameover)
