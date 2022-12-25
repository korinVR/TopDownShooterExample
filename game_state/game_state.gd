extends Node

var _score: int
var _player_left: int

signal score_updated(score: int)
signal player_left_updated(player_left: int)

func reset() -> void:
	_score = 0
	_player_left = 3
	score_updated.emit(_score)
	player_left_updated.emit(_player_left)

func add_score(value: int) -> void:
	_score += value
	score_updated.emit(_score)

func decrease_player() -> void:
	_player_left -= 1
	player_left_updated.emit(_player_left)

func is_gameover() -> bool:
	return _player_left < 0

