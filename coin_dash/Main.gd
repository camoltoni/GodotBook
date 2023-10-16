extends Node2D

export (PackedScene) var Coin
export (PackedScene) var PowerUp
export (int) var playtime

var level
var score
var time_left
var screensize
var playing = false

func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screen_size = screensize
	$Player.hide()

func _process(_delta):
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
		time_left += 5
		spawn_coins()

func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD.update_score(score)
	$HUD.update_time_left(time_left)

func spawn_coins():
	$LevelSound.play()
	$PowerUpTimer.start(rand_range(2, 4))
	for _i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))


func _on_GameTimer_timeout():
	time_left -= 1
	$HUD.update_time_left(time_left)
	if time_left < 0:
		game_over()

func _on_Player_pickup(type):
	if type == "coin":
		$CoinSound.play()
		score += 1
		$HUD.update_score(score)
	elif type == "powerup":
		time_left += 5
		$HUD.update_time_left(time_left)


func _on_Player_hurted():
	game_over()

func game_over():
	$GameOverSound.play()
	playing = false
	$GameTimer.stop()
	$PowerUpTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die()
	pass



func _on_PowerUpTimer_timeout():
	if playing:
		var pwr = PowerUp.instance()
		$CoinContainer.add_child(pwr)
		pwr.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
