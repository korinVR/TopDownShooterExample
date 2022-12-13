extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await $Title/Button.pressed
	print("presed!")
	$Title.free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

