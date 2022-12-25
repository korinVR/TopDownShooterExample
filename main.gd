extends Node3D

const TitleScene = preload("res://title/title.tscn")
const Player = preload("res://player/player.tscn")
const Message = preload("res://message/message.tscn")

signal reset_pressed()

func _ready() -> void:
	while true:
		var title_scene := TitleScene.instantiate()
		add_child(title_scene)
		await title_scene.game_started
		title_scene.queue_free()
		
		GameState.reset()
		
		for level_index in range(1, 3):
			_load_level(level_index)
			_show_message("LEVEL %d" % level_index)
			
			while true:
				if %Level/%Player == null:
					GameState.decrease_player()
					if GameState.is_gameover():
						break
					
					var player := Player.instantiate()
					var spwan_transform := (%Level/PlayerSpawnPoint as Node3D).global_transform
					player.global_transform = spwan_transform
					%Level.add_child(player)
					
					%PlayerCamera.reset()
					
				if get_tree().get_nodes_in_group("enemy").size() == 0:
					break
				
				await get_tree().process_frame
			
			if GameState.is_gameover():
				_show_message("GAME OVER")
				await get_tree().create_timer(3).timeout
				%Level.free()
				break
			
			_show_message("LEVEL COMPLETE")
			await get_tree().create_timer(3).timeout
			%Level.free()
		
		if !GameState.is_gameover():
			_show_message("ENDING")
			await get_tree().create_timer(3).timeout


func _load_level(level_index: int) -> void:
	var level := (load("res://levels/level_%d.tscn" % level_index) as PackedScene).instantiate()
	add_child(level)
	level.name = "Level"
	level.owner = self
	level.set_unique_name_in_owner(true)


func _show_message(text: String) -> void:
	var message := Message.instantiate()
	message.initialize(text)
	add_child(message)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Reset"):
		reset_pressed.emit()
