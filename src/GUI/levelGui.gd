extends Control

onready var playerHP = int(get_node("/root/playerStats").playerData["shipHP"])
onready var playerMaxHP = int(get_node("/root/playerStats").upgradeMaxValues["HP"])

func _ready():
	$CanvasLayer/MarginContainer/GridContainer/TextureProgress.max_value = int(range_lerp(playerHP,1,10,1,playerMaxHP))
	$CanvasLayer/MarginContainer/GridContainer/TextureProgress.value = int(range_lerp(playerHP,1,10,1,playerMaxHP))
	

func _on_Player_lootChanged(newValue):
	$CanvasLayer/MarginContainer/GridContainer/TextureRect3/lootAmount.text = String(newValue)


func _on_Player_hpChanged(newValue):
	$CanvasLayer/MarginContainer/GridContainer/TextureProgress.value = newValue
