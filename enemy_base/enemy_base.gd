extends RigidBody3D

func _on_body_entered(body):
	GameState.add_score(1000)
	queue_free()
