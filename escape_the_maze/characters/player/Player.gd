extends "res://characters/Character.gd"

signal moved
signal dead
signal grabbed_key
signal win

func _process(_delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					$FootSteps.play()
					emit_signal("moved")


func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		area.hide()
		set_process(false)
		$AnimationPlayer.play("die")
		yield($AnimationPlayer,"animation_finished")
		emit_signal("dead")
	if area.has_method("pickup"):
		area.pickup()
	if area.get("type") != null and area.type == "key_red":
		emit_signal("grabbed_key")
	if area.get("type") and area.type == "star":
		set_process(false)
		$CollisionShape2D.set_deferred("disabled", true)
		$Win.play()
		yield($Win, "finished")
		emit_signal("win")
