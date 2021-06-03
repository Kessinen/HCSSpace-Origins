extends "res://Enemies/enemies.gd"

var rofTimer = Timer.new()

export (PackedScene) var psBullet

func _ready():
	rofTimer.wait_time = RoF
	rofTimer.one_shot = true
	add_child(rofTimer)

func _physics_process(delta):
	move(delta)

func _process(delta):
	shoot()

func move(delta) -> void:
	var collision
	collision = move_and_collide(Vector2.DOWN * Speed * delta)

func shoot():
	if rofTimer.is_stopped() and RoF > 0:
		for gun in $Guns.get_children():
			var bullet = psBullet.instance()
			bullet.position = gun.global_position
			bullet.rotation = deg2rad(180)
			get_parent().add_child(bullet)
		rofTimer.start()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
