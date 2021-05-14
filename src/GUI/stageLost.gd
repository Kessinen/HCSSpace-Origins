extends Control

func _on_btnQuit_pressed():
	get_tree().change_scene("res://Menus/LevelSelect.tscn")
	queue_free()


func _on_btnRestart_pressed():
	get_tree().change_scene("res://Levels/Lvl1/Level1.tscn")
	queue_free()
