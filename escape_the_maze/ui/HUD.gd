extends CanvasLayer

onready var score = $MarginContainer/HBoxContainer/ScoreLabel

func _ready():
	score.text = str(Global.score)

func update_score(value):
	Global.score += value
	score.text = str(Global.score)
