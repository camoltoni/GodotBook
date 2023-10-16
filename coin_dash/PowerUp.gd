extends Area2D

func _ready():
	$Tween.interpolate_property($AnimatedSprite, 'scale',
								$AnimatedSprite.scale,
								$AnimatedSprite.scale * 0, 
								0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AnimatedSprite, 'modulate',
								Color(1, 1, 1, 1),
								Color(1, 1, 1, 0), 
								0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)

func pickup():
	_gone()

func _gone():
	set_deferred("monitoring", false)
	$Tween.start()
	yield($Tween, "tween_completed")
	call_deferred("queue_free")


func _on_Timer_timeout():
	_gone()
	pass # Replace with function body.
