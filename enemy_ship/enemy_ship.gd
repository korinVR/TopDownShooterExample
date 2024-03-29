extends RigidBody3D

@export var enemy_shot_speed: float

const EnemyShot := preload("res://enemy_shot/enemy_shot.tscn")

var shot_timer: float

var acceleration: float
var target_position_offset: Vector3

func _ready() -> void:
	shot_timer = randf_range(1, 2)
	target_position_offset = Vector3(randf_range(-30, 30), 0, randf_range(-30, 30))
	acceleration = randf_range(500000, 1500000)

func _physics_process(delta: float) -> void:
	if %Player == null:
		return
	var direction = (%Player.global_position + target_position_offset - global_position).normalized()
	apply_force(direction * acceleration)
	
	$Model.look_at(%Player.global_position)

func _process(delta: float) -> void:
	if %Player == null:
		return
	
	shot_timer -= delta
	if shot_timer > 0:
		return
	
	shot_timer = randf_range(1, 2)
	
	var enemy_shot := EnemyShot.instantiate()
	add_sibling(enemy_shot)
	enemy_shot.global_position = global_position
	enemy_shot.linear_velocity = (%Player.global_position - global_position).normalized() * enemy_shot_speed
	
	var direc

func _on_body_entered(body: Node) -> void:
	if body.get_collision_layer_value(2):
		GameState.add_score(100)
		queue_free()
