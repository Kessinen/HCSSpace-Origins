extends Control

onready var playerStats = get_node("/root/playerStats").playerData
onready var upgradeBaseValues = get_node("/root/playerStats").upgradeBasePrices
onready var upgradeCostMultipliers = get_node("/root/playerStats").upgradeCostMultiplier
onready var gameFunctions = get_node("/root/GameFunctions")

var selectedLevel : int = 0

var stats = ["HP", "Speed", "Handling", "RoF", "Damage", "Magnet"]

var descriptions = [
	{
		"title" : "Survive",
		"desc" : "Just just! Jos nyt hengissä selviäisit ni hyvä!"
	},{
		"title" : "TBA",
		"desc" : "Tulossa..."
	}
	]

func _ready():
	updateGui()
	updateShopButtons()

func updateShopButtons():
	var curCash : int = playerStats["lootAmount"]
	var statsPrefixPath = "VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/"
	var statsSufixPath = "/HBoxContainer/"
	
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer4/lblCash.text = "Cash: " + str(playerStats["lootAmount"]) + " $"
	
	for i in stats:
		var btnMin = get_node(statsPrefixPath + i + statsSufixPath + "btnMin")
		var pbarValue = get_node(statsPrefixPath + i + statsSufixPath + "pbarValue")
		var btnPlus = get_node(statsPrefixPath + i + statsSufixPath + "btnPlus")
		var lblTitle = get_node(statsPrefixPath + i + statsSufixPath + "lblTitle")

		pbarValue.value = playerStats["ship"+i]
		if pbarValue.value == 1:
			btnMin.disabled = true
			print("Disabling: ", i)
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
		lblTitle.text = i + " (" + str(nextLevelCost) + ")"
		btnMin.connect("pressed", self, "decreaseStat", [i])
		btnPlus.connect("pressed", self, "increaseStat", [i])

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
		get_node("VBoxContainer/HBoxContainer/VBoxContainer2/levelsGrid/Lvl"+str(i+1)).disabled = false
	
	
	var statsBasePath = "VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/"
	for i in stats:
		var parsedPath = statsBasePath + i + "/HBoxContainer/pbarValue"
		get_node(parsedPath).value = playerStats["ship" + i]
		pass

func _on_LvlSelected_pressed(extra_arg_0):
	selectedLevel = extra_arg_0
	$VBoxContainer/HBoxContainer/VBoxContainer2/Panel/VBoxContainer/lblTitle.text = "Objectives: " + descriptions[extra_arg_0-1]["title"]
	$VBoxContainer/HBoxContainer/VBoxContainer2/Panel/VBoxContainer/lblDesc.text = "Info: " + descriptions[extra_arg_0-1]["desc"]
	$VBoxContainer/HBoxContainer2/HBoxContainer/btnLaunch.disabled = false

func _on_btnLaunch_pressed():
	get_tree().change_scene("res://Levels/Lvl"+str(selectedLevel)+"/Level"+str(selectedLevel)+".tscn")

func _on_btnSaveGame_pressed():
	gameFunctions.saveGameData()
