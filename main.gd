extends Node3D

const TitleScene = preload("res://title/title.tscn")
const GameScene = preload("res://game.tscn")

const Player = preload("res://player/player.tscn")

signal reset_pressed()

func _ready() -> void:
	while true:
#		var title_scene := TitleScene.instantiate()
#		add_child(title_scene)
#		await title_scene.game_started
#		title_scene.queue_free()
		
		var game_scene := GameScene.instantiate()
		add_child(game_scene)
		
		var player := Player.instantiate()
		var spwan_transform := (game_scene.get_node("PlayerSpawnPoint") as Node3D).global_transform
		player.global_transform = spwan_transform
		game_scene.add_child(player)
		
		await reset_pressed
		game_scene.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Reset"):
		reset_pressed.emit()

