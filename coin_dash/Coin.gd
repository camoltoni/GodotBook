extends Area2D

var screensize

func _ready():
	$Tween.interpolate_property($AnimatedSprite, 'scale',
								$AnimatedSprite.scale,
								$AnimatedSprite.scale * 3, 
								0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AnimatedSprite, 'modulate',
								Color(1, 1, 1, 1),
								Color(1, 1, 1, 0), 
								0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)
	yield(get_tree().create_timer(rand_range(0, 0.5)),"timeout")
	$AnimatedSprite.playing = true

func pickup():
	set_deferred("monitoring", false)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()


func _on_Coin_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
