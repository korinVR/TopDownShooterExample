extends Node2D

func _ready() -> void:
	GameState.score_updated.connect(self.on_score_updated)

func on_score_updated(score: int) -> void:
	$ScoreLabel/Score.text = var_to_str(score)

