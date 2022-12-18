extends Node3D

const TitleScene = preload("res://title.tscn")
const GameScene = preload("res://game.tscn")

const Player = preload("res://player.tscn")

func _ready() -> void:
	while true:
		var title_scene := TitleScene.instantiate()
		add_child(title_scene)
		await title_scene.game_started
		title_scene.queue_free()
		
		var game_scene := GameScene.instantiate()
		add_child(game_scene)
		
		var player := Player.instantiate()
		var spwan_transform := (game_scene.get_node("PlayerSpawnPoint") as Node3D).global_transform
		player.global_transform = spwan_transform
		game_scene.add_child(player)
		
		break

#		while true:
#			if Input.is_key_pressed(KEY_R):
#				break
#			await get_tree().create_timer(0).timeout
#
#		game_scene.queue_free()
