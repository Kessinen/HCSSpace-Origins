extends Control

onready var playerStats = get_node("/root/playerStats").playerData
onready var skillCosts = get_node("/root/playerStats").skillCosts
onready var gameFunctions = get_node("/root/GameFunctions")

var selectedLevel : int = 0

var descriptions = [
	{
		"title" : "Survive",
		"desc" : "You've barely escaped! The enemy is hot on your trail so you decide to try to out maneuver them in the near by asteroid field. Just don't die on me."
	},{
		"title" : "Kill 5 enemies",
		"desc" : "Oh NO! A small fighter group has managed to pursue you in to the asteroid field. Destroy them! Before they give away your position to the main fleet."
	}
	]

func _ready():
	MusicController.changeMusic("Mainmenu")
	gameFunctions.saveGameData()
	for stat in $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/UpgradeShip/VBoxContainer/MarginContainer/MarginContainer/vboxStats/.get_children():
		stat.connect("shopEvent",self, "_on_shopEvent")
	$lblCash.text = str(playerStats["lootAmount"], " $")	

func _on_shopEvent():
	for stat in $TextureRect/MarginContainer/HBoxContainer/VBoxContainer/UpgradeShip/VBoxContainer/MarginContainer/MarginContainer/vboxStats/.get_children():
		stat.updatebar()
	$lblCash.text = str(playerStats["lootAmount"], " $")

func _on_LvlSelected_pressed(extra_arg_0):
	selectedLevel = extra_arg_0
	$TextureRect/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/lblMissionObjective.text = "Objectives: " + descriptions[extra_arg_0-1]["title"]
	$TextureRect/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/lblMissionDescription.text = descriptions[extra_arg_0-1]["desc"]
	$TextureRect/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer2/HBoxContainer/btnLaunch.disabled = false

func _on_btnLaunch_pressed():
	get_tree().change_scene("res://Levels/Lvl"+str(selectedLevel)+"/Level"+str(selectedLevel)+".tscn")

func _on_btnSaveGame_pressed():
	gameFunctions.saveGameData()

func _on_btnMainmenu_pressed():
	gameFunctions.saveGameData()
	get_tree().change_scene("res://Menus/Mainmenu.tscn")

func _on_skill_pressed(extra_arg_0):
	var skillsuffix = "TextureRect/MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/VBoxContainer/MarginContainer2/GridContainer/skill"
	if get_node(skillsuffix + str(extra_arg_0)).pressed == false:
		get_node(skillsuffix + str(extra_arg_0)).pressed = true
		playerStats["skill"+str(extra_arg_0)] = true
	else:
		playerStats["skill"+str(extra_arg_0)] = true
		playerStats["lootAmount"] -= skillCosts[extra_arg_0-1]
