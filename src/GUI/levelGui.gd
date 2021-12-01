extends Control

var statsData = statData.stats

onready var playerHP = statsData["armor"][str(get_node("/root/playerStats").playerData["armor"])]["hull"]
onready var playerMaxHP = statsData["armor"][str(get_node("/root/playerStats").playerData["armor"])]["hull"]

func _ready():
	$CanvasLayer/MarginContainer/GridContainer/TextureProgress.max_value = playerMaxHP
	$CanvasLayer/MarginContainer/GridContainer/TextureProgress.value = playerMaxHP
	
func _on_Player_lootChanged(newValue):
	$CanvasLayer/MarginContainer/GridContainer/TextureRect3/lootAmount.text = str(newValue)

func _on_Player_hpChanged(newValue):
	$CanvasLayer/MarginContainer/GridContainer/TextureProgress.value = newValue
