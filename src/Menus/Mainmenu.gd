extends Control

onready var gameFunctions = get_node("/root/GameFunctions")
onready var saveG = get_node("/root/playerStats").playerData
onready var saveFile := File.new()

func _ready():
	if saveFile.file_exists(gameFunctions.saveFileName):
		$VBoxContainer/btnContinue.disabled = false
	$lblVersion.text = "Version: " + ProjectSettings.get_setting("application/config/version")

func _on_btnQuit_pressed():
	get_tree().quit()

func _on_btnNewGame_pressed():
	get_tree().change_scene("res://Menus/LevelSelect.tscn")

func _on_btnContinue_pressed():
	gameFunctions.loadGameData()
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
