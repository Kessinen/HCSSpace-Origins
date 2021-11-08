extends "res://Entities/Enemies/Enemy.gd"

var is_Homing: bool = false
var target_Location: Vector2

func _ready():
	rotate(deg2rad(90))

func _physics_process(delta):
	if is_Homing:
		look_at(target_Location)
		move_and_collide(global_position.direction_to(target_Location) * Speed * delta)
	else:
		move_and_collide(Vector2.DOWN * Speed * delta)

func _process(delta):
	if global_position.distance_to(target_Location) < 1:
		die()
		
func die():
	
	$AnimationPlayer.play("Die")

func _on_SearchArea_body_entered(body):
	if body.get_name() == "Player":
		target_Location = body.global_position
		is_Homing = true
