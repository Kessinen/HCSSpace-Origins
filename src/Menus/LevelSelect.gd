extends Control

onready var playerStats = get_node("/root/playerStats")

var selectedLevel : int = 0

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
	

func updateGui():
	for i in range(0, playerStats.highestLevel):
		get_node("VBoxContainer/HBoxContainer/VBoxContainer2/levelsGrid/Lvl"+str(i+1)).disabled = false
		
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer4/lblCash.text = "Cash: " + str(playerStats.lootAmount) + " $"
	
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer/HBoxContainer/pbarHP.value = playerStats.shipHP
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer7/HBoxContainer/pbarSpeed.value = playerStats.shipSpeed
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer2/HBoxContainer/pbarHandling.value = playerStats.shipHandling
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer3/HBoxContainer/pbarRof.value = playerStats.shipRoF
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer5/HBoxContainer/pbarDamage.value = playerStats.shipDamage
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer6/HBoxContainer/pbarMagnet.value = playerStats.shipMagnet

func _on_LvlSelected_pressed(extra_arg_0):
	selectedLevel = extra_arg_0
	$VBoxContainer/HBoxContainer/VBoxContainer2/Panel/VBoxContainer/lblTitle.text = "Objectives: " + descriptions[extra_arg_0-1]["title"]
	$VBoxContainer/HBoxContainer/VBoxContainer2/Panel/VBoxContainer/lblDesc.text = "Info: " + descriptions[extra_arg_0-1]["desc"]
	$VBoxContainer/HBoxContainer2/HBoxContainer/btnLaunch.disabled = false

func _on_btnLaunch_pressed():
	get_tree().change_scene("res://Levels/Lvl"+str(selectedLevel)+"/Level"+str(selectedLevel)+".tscn")

