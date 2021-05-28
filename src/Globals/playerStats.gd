extends Node

var playerData = {
	"version" : "",
	"lootAmount" : 0,
	"shipHP" : 1,
	"shipShields" : 1,
	"shipRoF" : 1,
	"shipDamage" : 1,
	"shipHandling" : 1,
	"shipMagnet" : 1,
	"shipSpeed" : 1,
	"highestLevel" :1,
	"skill1" : false,
	"skill2" : false,
	"skill3" : false
}
var upgradeCostMultiplier = {
	"HP" : 1.5,
	"Shields" : 1,
	"RoF" : 1.2,
	"Damage" : 2,
	"Handling" : 1.2,
	"Magnet" : 1.5,
	"Speed" : 1.3,
}
var upgradeBasePrices = {
	"HP" : 100,
	"Shields" : 1,
	"RoF" : 110,
	"Damage" : 200,
	"Handling" : 120,
	"Magnet" : 150,
	"Speed" : 130,
}

var skillCosts = [1500,2000,800]

