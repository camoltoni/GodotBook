extends Node

var levels = ["res://maps/levels/Level1.tscn"]
var current_level
var score

var start_screen = "res://ui/StartScreen.tscn"
var end_screen = "res://ui/EndScreen.tscn"

func new_game():
	score = 0
	current_level = -1
	next_level()

func game_over():
	assert(get_tree().change_scene(end_screen) == OK)

func next_level():
	current_level += 1
	if current_level >= Global.levels.size():
		game_over()
	else:
		assert(get_tree().change_scene(levels[current_level]) == OK)
