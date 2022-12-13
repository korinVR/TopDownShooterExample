extends Node3D

const TitleScene = preload("res://title.tscn")
const GameScene = preload("res://game.tscn")

func _ready() -> void:
	while true:
		var title_scene = TitleScene.instantiate()
		add_child(title_scene)
		await title_scene.game_started
		title_scene.queue_free()
		
		var game_scene = GameScene.instantiate()
		add_child(game_scene)
		await get_tree().create_timer(1).timeout
		game_scene.queue_free()
