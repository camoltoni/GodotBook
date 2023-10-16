extends Area2D

signal pickup
signal hurted

export (int) var speed
var velocity = Vector2()
var screen_size = Vector2(480, 720)

func _process(delta):
	get_input()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func start(pos:Vector2):
	set_process(true)
	position = pos
	$AnimatedSprite.play("idle")

func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length_squared() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.play("idle")

func die():
	$AnimatedSprite.play("hurt")
	set_process(false)

func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
		area.pickup()
		emit_signal("pickup", "coin")
	if area.is_in_group("powerups"):
		area.pickup()
		emit_signal("pickup", "powerup")
	if area.is_in_group("obstacles"):
		emit_signal("hurted")
		die()
