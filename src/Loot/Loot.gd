extends Sprite

export var lootSpeed : int = 20
export var lootValue : int = 1

func _physics_process(delta):
	position.y += lootSpeed * delta
