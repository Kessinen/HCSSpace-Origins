extends Control

onready var playerStats = get_node("/root/playerStats").playerData
onready var upgradeBaseValues = get_node("/root/playerStats").upgradeBasePrices
onready var upgradeCostMultipliers = get_node("/root/playerStats").upgradeCostMultiplier
onready var skillCosts = get_node("/root/playerStats").skillCosts
onready var gameFunctions = get_node("/root/GameFunctions")

var selectedLevel : int = 0

var stats = ["HP", "Speed", "Handling", "RoF", "Damage", "Magnet"]

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
	updateGui()
	updateShopButtons()
	gameFunctions.saveGameData()
	
	for i in stats:
		var statsPrefixPath = "TextureRect/MarginContainer/HBoxContainer/VBoxContainer/UpgradeShip/VBoxContainer/MarginContainer/MarginContainer/VBoxContainer/"
		var statsSufixPath = "/MarginContainer/HBoxContainer/"
		var btnMin = get_node(statsPrefixPath + i + statsSufixPath + "minus")
		var btnPlus = get_node(statsPrefixPath + i + statsSufixPath + "plus")
		btnMin.connect("pressed", self, "decreaseStat", [i])
		btnPlus.connect("pressed", self, "increaseStat", [i])
	
	for i in range(2,10):
		get_node("TextureRect/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/GridContainer/btnlvl" + str(i)).connect("pressed",self,"_on_LvlSelected_pressed",[2])

func updateShopButtons():
	var curCash : int = playerStats["lootAmount"]
	
	var statsPrefixPath = "TextureRect/MarginContainer/HBoxContainer/VBoxContainer/UpgradeShip/VBoxContainer/MarginContainer/MarginContainer/VBoxContainer/"
	var statsSufixPath = "/MarginContainer/HBoxContainer/"
	$lblCash.text = "Cash: " + str(playerStats["lootAmount"]) + " $"
	
	for i in stats:
		var btnMin = get_node(statsPrefixPath + i + statsSufixPath + "minus")
		var pbarValue = get_node(statsPrefixPath + i + statsSufixPath + "pb" + i)
		var btnPlus = get_node(statsPrefixPath + i + statsSufixPath + "plus")
		var lblTitle = get_node(statsPrefixPath + i + statsSufixPath + "cost")

		pbarValue.value = playerStats["ship"+i]
		if pbarValue.value == 1:
			btnMin.disabled = true
		else:
			btnMin.disabled = false

		#Calculate costs and enable buttons accordingly
		var curLevelCost = playerStats["ship"+i] * upgradeBaseValues[i] * upgradeCostMultipliers[i]
		var nextLevelCost = (playerStats["ship"+i] + 1) * upgradeBaseValues[i] * upgradeCostMultipliers[i]
		var previousLevelCost = (playerStats["ship"+i] - 1) * upgradeBaseValues[i] * upgradeCostMultipliers[i]
		var refund = curLevelCost
		if pbarValue.value == 10 or curCash - nextLevelCost < 0:
			btnPlus.disabled = true
		else:
			btnPlus.disabled = false
		lblTitle.text = "$ " + str(nextLevelCost)
		
	
	for i in range(1,4):
		var skillsuffix = "TextureRect/MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/VBoxContainer/MarginContainer2/GridContainer/skill"
		if playerStats["skill"+str(i)]:
			get_node(skillsuffix + str(i)).disabled = false
			get_node(skillsuffix + str(i)).pressed = true
		elif playerStats["lootAmount"] >= skillCosts[i-1]:
			get_node(skillsuffix + str(i)).disabled = false
		else:
			get_node(skillsuffix + str(i)).disabled = true
		
		

func increaseStat(stat):
	var curStatLevel = playerStats["ship"+stat]
	var levelupCost = (curStatLevel + 1) * upgradeBaseValues[stat] * upgradeCostMultipliers[stat]
	playerStats["ship"+stat] += 1
	playerStats["lootAmount"] -= levelupCost
	updateShopButtons()

func decreaseStat(stat):
	var curStatLevel = playerStats["ship"+stat]
	var refund = (curStatLevel) * upgradeBaseValues[stat] * upgradeCostMultipliers[stat]
	stat = "ship" + stat
	playerStats[stat] -= 1
	playerStats["lootAmount"] += refund
	updateShopButtons()

func updateGui():
	for i in range(0, playerStats["highestLevel"]):
		get_node("TextureRect/MarginContainer/HBoxContainer/VBoxContainer2/MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/GridContainer/btnlvl"+str(i+1)).disabled = false
	
	"TextureRect/MarginContainer/HBoxContainer/VBoxContainer/UpgradeShip/VBoxContainer/MarginContainer/MarginContainer/VBoxContainer/HP/MarginContainer/HBoxContainer/pbHP"
	var statsBasePath = "TextureRect/MarginContainer/HBoxContainer/VBoxContainer/UpgradeShip/VBoxContainer/MarginContainer/MarginContainer/VBoxContainer/"
	for i in stats:
		var parsedPath = statsBasePath + i + "/MarginContainer/HBoxContainer/pb" + i
		get_node(parsedPath).value = playerStats["ship" + i]
	
	for i in range(1,4):
		var skillLabel = get_node("TextureRect/MarginContainer/HBoxContainer/VBoxContainer/MarginContainer2/VBoxContainer/MarginContainer2/GridContainer/lblSkill" + str(i))
		skillLabel.text = skillLabel.text.replace("1000", skillCosts[i-1])
		

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
		updateShopButtons()
