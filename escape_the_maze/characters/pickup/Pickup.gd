extends Area2D

signal coin_pickup
signal key_grabbed

var textures = {
	"coin"		: "res://assets/coin.png",
	"key_red"	: "res://assets/keyRed.png",
	"star"		: "res://assets/star.png"
}

var type 

var streams = {
	"coin"		: "res://assets/audio/coin_pickup.ogg",
	"key_red"	: "res://assets/audio/key_grabbed.ogg",
	"star"		: "res://assets/audio/key_grabbed.ogg"
}

func _ready():
	$Tween.interpolate_property(
		$Sprite, 
		"scale", 
		Vector2(1, 1), 
		Vector2(3,3), 
		0.5, 
		Tween.TRANS_QUAD, 
		Tween.EASE_IN_OUT)
	$Tween.interpolate_property(
		self,
		"modulate",
		Color(1, 1, 1, 1),
		Color(1, 1, 1, 0),
		0.5,
		Tween.TRANS_QUAD,
		Tween.EASE_IN_OUT
	)

func init(_type, pos):
	$Sprite.texture = load(textures[_type])
	$AudioStreamPlayer.stream = load(streams[_type])
	position = pos
	type = _type

func pickup():
	match type:
		"coin":
			emit_signal("coin_pickup", 1)
			$AudioStreamPlayer.play()
		"key_red":
			emit_signal("key_grabbed")
			$AudioStreamPlayer.play()
	$CollisionShape2D.set_deferred("disabled", true)
	$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	queue_free()
