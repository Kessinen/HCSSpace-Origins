extends Control

func _on_Player_lootChanged(newValue):
	$CanvasLayer/MarginContainer/GridContainer/TextureRect3/lootAmount.text = String(newValue)
