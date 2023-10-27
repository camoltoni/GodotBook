extends Area2D

export (int) var speed

var tile_size = 64
onready var can_move = true
var facing = Vector2.RIGHT

var moves = {	"down"	: Vector2.DOWN,
				"left"	: Vector2.LEFT,
				"right"	: Vector2.RIGHT, 
				"up"	: Vector2.UP}

onready var raycasts = {"down"	: $RayCastDown,
						"left"	: $RayCastLeft,
						"right"	: $RayCastRight,
						"up"	: $RayCastUp}

func move(dir) -> bool:
	$AnimationPlayer.playback_speed = speed
	facing = dir
	if raycasts[facing].is_colliding():
		return false
	can_move = false
	$AnimationPlayer.play(facing)
	$MoveTween.interpolate_property(self, 
									"position", 
									position,
									position + moves[facing] * tile_size, 
									1.0/speed, 
									Tween.TRANS_SINE, 
									Tween.EASE_IN_OUT)
	$MoveTween.start()
	return true


func _on_MoveTween_tween_completed(_object, _key):
	can_move = true
