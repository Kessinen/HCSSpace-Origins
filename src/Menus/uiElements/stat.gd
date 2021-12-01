extends HBoxContainer

export (String, "armor", "engines", "utilities", "weapons") var stat : String = "armor"

var curLevel: int

onready var statsData = statData.stats
onready var curPlayerStats = playerStats.playerData
onready var nextLevelCost = statsData[stat][str(clamp(curLevel+1,1,10))]["cost"]

signal shopEvent

func _ready():
	$lblStatName.text = stat
	updatebar()
	pass

func updatebar():
	curLevel = curPlayerStats[stat]
	nextLevelCost = statsData[stat][str(clamp(curLevel+1,1,10))]["cost"]
	$HBoxContainer/TextureProgress.value = curLevel
	
	match curPlayerStats[stat]:
		10:
			$HBoxContainer/btnPlus.disabled = true
			$HBoxContainer/btnMinus.disabled = false
			$lblCost.text = "MAX"
		1:
			$HBoxContainer/btnPlus.disabled = false
			$HBoxContainer/btnMinus.disabled = true
			$lblCost.text = str(nextLevelCost, " $")
		_:
			$HBoxContainer/btnPlus.disabled = false
			$HBoxContainer/btnMinus.disabled = false
			$lblCost.text = str(nextLevelCost, " $")

	if curPlayerStats["lootAmount"] < nextLevelCost:
		$HBoxContainer/btnPlus.disabled = true

func _on_btnMinus_pressed():
	curPlayerStats[stat] -= 1
	curPlayerStats["lootAmount"] += statsData[stat][str(curLevel)]["cost"]
	emit_signal("shopEvent")


func _on_btnPlus_pressed():
	curPlayerStats[stat] += 1
	curPlayerStats["lootAmount"] -= statsData[stat][str(clamp(curLevel+1,1,10))]["cost"]
	emit_signal("shopEvent")
