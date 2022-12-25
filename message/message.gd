extends Node2D

func initialize(message: String) -> void:
	$Label.text = message

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	queue_free()
