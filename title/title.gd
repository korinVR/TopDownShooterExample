extends Node2D

signal game_started()

func _ready() -> void:
	await $Button.pressed
	game_started.emit()
