extends "res://characters/Character.gd"

func _ready():
	can_move = false
	facing = moves.keys()[randi() % moves.size()]
	yield(get_tree().create_timer(0.5),"timeout")
	can_move = true

func _process(_delta):
	if can_move:
		if not move(facing) or randi() % 10 > 7:
			facing = moves.keys()[randi() % moves.size()]
