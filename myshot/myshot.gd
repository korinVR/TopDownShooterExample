extends RigidBody3D

func _on_body_entered(body: Node) -> void:
	queue_free()
