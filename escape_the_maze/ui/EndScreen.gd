extends Control



func _on_Timer_timeout():
	assert(get_tree().change_scene(Global.start_screen) == OK)
