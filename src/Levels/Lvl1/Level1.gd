extends "res://Levels/levels.gd"

var plPlayer = preload("res://Player/Player.tscn")

func _ready():
	var player = plPlayer.instance()
	player.position = PlayerStartingPos
	self.add_child(player)
