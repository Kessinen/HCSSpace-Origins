extends "res://Enemies/enemies.gd"

var plLoot = preload("res://Loot/Loot.tscn")

func _ready():
	randomize()
	rotate(deg2rad(rand_range(0,90) - 45))
	
func _physics_process(delta):
	move_and_slide(Vector2.DOWN.rotated(rotation) * Speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _exit_tree():
	var loot = plLoot.instance()
	loot.lootValue = enemyLevel * 10
	loot.position = global_position
	get_parent().add_child(loot)
	

