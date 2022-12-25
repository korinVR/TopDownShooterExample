extends Node2D

func _ready() -> void:
	GameState.score_updated.connect(_on_score_updated)
	GameState.player_left_updated.connect(_on_player_left_updated)

func _on_score_updated(score: int) -> void:
	$ScoreLabel/Score.text = str(score)

func _on_player_left_updated(player_left: int) -> void:
	$PlayerLeftLabel/PlayerLeft.text = str(clampi(player_left, 0, 99))
