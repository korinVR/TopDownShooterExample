extends Node3D

func _ready() -> void:
	await get_tree().create_timer(0.05).timeout
	queue_free()
