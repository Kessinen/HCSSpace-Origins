extends bullets

func _ready():
	var scaleBullet := 0.2
	$Sprite.texture = bulletSprite
	$Sprite.scale = Vector2.ONE * scaleBullet
	
func _physics_process(delta):
	position += Vector2.UP.rotated(rotation) * bulletSpeed * delta
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet2_body_entered(body: Node2D):
	if playerBullet:
		if body.is_in_group("Enemies"):
			body.takeDamage(bulletDamage)
	else:
		if body.name == "Player":
			body.takeDamage(bulletDamage)
			
