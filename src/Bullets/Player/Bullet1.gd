extends "res://Bullets/bullets.gd"

func _ready():
	playerBullet = true

func _physics_process(delta):
	position.y = position.y - bulletSpeed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet1_body_entered(body):
	if body.is_in_group("Enemies"):
		body.takeDamage(bulletDamage)
		if playerStats["skill3"]:
			randomize()
			var result : float = rand_range(0,1)
			if result > 0.3:
				queue_free()
		else:
			queue_free()
