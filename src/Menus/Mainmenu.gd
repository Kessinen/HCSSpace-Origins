extends Control

onready var gameFunctions = get_node("/root/GameFunctions")
onready var saveG = get_node("/root/playerStats").playerData
onready var saveFile := File.new()

onready var fadein : float = gameFunctions.menuFade

func _ready():
	if saveFile.file_exists(gameFunctions.saveFileName):
		$VBoxContainer/btnContinue.disabled = false
	$lblVersion.text = "Version: " + ProjectSettings.get_setting("application/config/version")
	MusicController.playMusic("Mainmenu")
	
	$ColorRect.color = Color(0,0,0,1)
	$Tween.interpolate_property($ColorRect,"modulate",Color(0,0,0,1),Color(0,0,0,0),fadein,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()

func _on_btnQuit_pressed():
	$Tween.interpolate_property($ColorRect,"modulate",Color(0,0,0,0),Color(0,0,0,1),fadein,Tween.TRANS_LINEAR,Tween.EASE_IN)
	$Tween.start()
	yield(get_tree().create_timer(fadein),"timeout")
	get_tree().quit()

func _on_btnNewGame_pressed():
	get_tree().change_scene("res://Menus/LevelSelect.tscn")

func _on_btnContinue_pressed():
	gameFunctions.loadGameData()
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
