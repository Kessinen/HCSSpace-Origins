extends Control

func _on_Player_lootChanged(newValue):
	$Container/loot.text = String(newValue)
