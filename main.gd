extends Node3D

const TitleScene = preload("res://title/title.tscn")
const Level = preload("res://levels/level_1.tscn")

const Player = preload("res://player/player.tscn")

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
			print(level_index)
			
			var level := Level.instantiate()
			add_child(level)
			level.name = "Level"
			level.owner = self
			level.set_unique_name_in_owner(true)
			
			var is_gameover := false
			
			while true:
				if %Level/%Player == null:
					player_left -= 1
					print(player_left)
					
					if player_left == 0:
						is_gameover = true
						break
					
					var player := Player.instantiate()
					var spwan_transform := (level.get_node("PlayerSpawnPoint") as Node3D).global_transform
					player.global_transform = spwan_transform
					level.add_child(player)
					
				if get_tree().get_nodes_in_group("enemy").size() == 0:
					break
				
				await get_tree().process_frame
			
			level.free()
			
			if is_gameover:
				break

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Reset"):
		reset_pressed.emit()
