extends Control


func _on_btnQuit_pressed():
	get_tree().quit()


func _on_btnNewGame_pressed():
	get_tree().change_scene("res://Levels/Lvl1/Level1.tscn")