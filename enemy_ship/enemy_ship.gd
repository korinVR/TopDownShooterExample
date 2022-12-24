extends RigidBody3D

@export var acceleration: float

const EnemyShot := preload("res://enemy_shot/enemy_shot.tscn")

var shot_timer: float

func _ready() -> void:
	shot_timer = randf_range(1, 2)

func _physics_process(delta: float) -> void:
	var players := get_tree().get_nodes_in_group("player")
	if players.size() == 0:
		return
	
	var player := players[0]
	
	var direction = (player.global_position - global_position).normalized()
	apply_force(direction * acceleration)

func _process(delta: float) -> void:
	shot_timer -= delta
	if shot_timer < 0:
		print("fire")
		shot_timer = randf_range(1, 2)
		
		var enemy_shot := EnemyShot.instantiate()
		add_sibling(enemy_shot)
		enemy_shot.global_position = global_position

func _on_body_entered(body: Node) -> void:
	queue_free()
