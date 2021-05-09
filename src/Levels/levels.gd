extends Node

var PlayerStartingPos : Vector2

func _ready():
	PlayerStartingPos = Vector2(get_viewport().size.x / 2,get_viewport().size.y - 64)
