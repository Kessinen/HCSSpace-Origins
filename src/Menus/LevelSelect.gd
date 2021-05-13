extends Control

onready var playerStats = get_node("/root/playerStats")

var selectedLevel : int = 0

func _ready():
	
	for i in range(0, playerStats.highestLevel):
		get_node("VBoxContainer/HBoxContainer/levelsGrid/Lvl"+str(i+1)).disabled = false
	
	$VBoxContainer/HBoxContainer/VBoxContainer/VBoxContainer/PanelContainer4/lblCash.text = "Cash: " + str(playerStats.lootAmount) + " $"

func _on_LvlSelected_pressed(extra_arg_0):
	selectedLevel = extra_arg_0
	$VBoxContainer/HBoxContainer2/btnLaunch.disabled = false


func _on_btnLaunch_pressed():
	get_tree().change_scene("res://Levels/Lvl"+str(selectedLevel)+"/Level"+str(selectedLevel)+".tscn")
