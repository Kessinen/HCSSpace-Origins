extends Node

var stats = {}

func _ready():
	var datafile = File.new()
	datafile.open("res://Data/playerStats.json", File.READ)
	var datajson = JSON.parse(datafile.get_as_text())
	datafile.close()
	stats = datajson.result
