extends KinematicBody2D

onready var playerStats = get_node("/root/playerStats").playerData

export var lootSpeed : int = 20
export var lootValue : int = 1

var lootColors = {1 : Color.saddlebrown, 10 : Color.silver, 100: Color.gold}

func _ready():
	modulate = lootColors[1]
	for value in lootColors:
		if lootValue >= value:
			modulate = lootColors[value]

func _physics_process(delta):
	position.y += lootSpeed * delta

func pickUp(destination: Vector2):
	var curPos = global_position
	$Tween.interpolate_property(self,"global_position",curPos,destination,0.35,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$Tween.start()
	$AnimationPlayer.play("pickUp")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
