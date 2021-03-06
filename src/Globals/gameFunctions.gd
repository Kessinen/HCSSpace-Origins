extends Node

onready var playerStats = get_node("/root/playerStats")
onready var saveFile = File.new()

var saveFileName : String = "user://save.dat"

var menuFade := 0.3

func saveGameData():
	
	playerStats.playerData["version"] = ProjectSettings.get_setting("application/config/version")
	var retval = saveFile.open(saveFileName, File.WRITE)
	if retval == OK:
		saveFile.store_var(playerStats.playerData)
		saveFile.close()
	
func loadGameData():
	var retval = saveFile.open(saveFileName, File.READ)
	if retval == OK:
		var data = saveFile.get_var()
		for i in data:
			playerStats.playerData[i] = data[i]
		saveFile.close()
