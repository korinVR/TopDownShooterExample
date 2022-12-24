extends RigidBody3D

@export var acceleration: float

func _physics_process(delta: float) -> void:
	var players := get_tree().get_nodes_in_group("player")
	if players.size() == 0:
		return
	
	var player := players[0]
	
	var direction = (player.global_position - global_position).normalized()
	apply_force(direction * acceleration)

func _on_body_entered(body: Node) -> void:
	queue_free()
