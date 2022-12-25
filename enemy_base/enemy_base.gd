extends RigidBody3D

func _on_body_entered(body):
	if body.get_collision_layer_value(2):
		GameState.add_score(1000)
		queue_free()
