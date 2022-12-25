extends Node3D

const TitleScene = preload("res://title/title.tscn")
const Level = preload("res://levels/level_1.tscn")

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
		
		var player_left := 3
		
		for level_index in range(1, 2):
			var stage_message := Message.instantiate()
			stage_message.initialize("STAGE %d" % level_index)
			add_child(stage_message)
			
			var level := Level.instantiate()
			add_child(level)
			level.name = "Level"
			level.owner = self
			level.set_unique_name_in_owner(true)
			
			while true:
				if %Level/%Player == null:
					GameState.decrease_player()
					if GameState.is_gameover():
						break
					
					var player := Player.instantiate()
					var spwan_transform := (level.get_node("PlayerSpawnPoint") as Node3D).global_transform
					player.global_transform = spwan_transform
					level.add_child(player)
					
				if get_tree().get_nodes_in_group("enemy").size() == 0:
					break
				
				await get_tree().process_frame
			
			if GameState.is_gameover():
				var message := Message.instantiate()
				message.initialize("GAME OVER")
				add_child(message)
				
				await get_tree().create_timer(5).timeout
				level.free()
				break
			
			# Level clear
			var message := Message.instantiate()
			message.initialize("STAGE CLEAR")
			add_child(message)
			
			await get_tree().create_timer(5).timeout
			level.free()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Reset"):
		reset_pressed.emit()
