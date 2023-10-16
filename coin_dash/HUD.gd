extends CanvasLayer

signal start_game

func update_score(value):
	$MarginContainer/HBoxContainer/LabelScore.text = str(value)

func update_time_left(value):
	$MarginContainer/HBoxContainer/LabelTimeLeft.text = str(value)

func show_message(text):
	$LabelMessage.text = text
	$LabelMessage.show()
	yield(get_tree().create_timer(2), "timeout")
	$LabelMessage.hide()


func _on_ButtonStart_pressed():
	$ButtonStart.hide()
	$LabelMessage.hide()
	emit_signal("start_game")

func show_game_over():
	show_message("Game Over")
	yield(get_tree().create_timer(3), "timeout")
	$ButtonStart.show()
	$LabelMessage.text = "Coin Dash"
	$LabelMessage.show()
