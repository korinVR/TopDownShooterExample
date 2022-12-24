extends Node3D

const TitleScene = preload("res://title/title.tscn")
const Level = preload("res://levels/level_1.tscn")

const Player = preload("res://player/player.tscn")

signal reset_pressed()

func _ready() -> void:
	while true:
#		var title_scene := TitleScene.instantiate()
#		add_child(title_scene)
#		await title_scene.game_started
#		title_scene.queue_free()
		
		var level := Level.instantiate()
		add_child(level)
		level.name = "Level"
		
		var player := Player.instantiate()
		var spwan_transform := (level.get_node("PlayerSpawnPoint") as Node3D).global_transform
		player.global_transform = spwan_transform
		level.add_child(player)
		
		await reset_pressed
		level.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Reset"):
		reset_pressed.emit()
