extends Node

var _score := 0

signal score_updated(score: int)

func reset() -> void:
	_score = 0
	score_updated.emit(_score)

func add_score(value: int) -> void:
	_score += value
	score_updated.emit(_score)
