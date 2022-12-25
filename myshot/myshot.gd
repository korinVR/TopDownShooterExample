extends RigidBody3D

const Explosion := preload("res://explosion/explosion.tscn")

func _ready() -> void:
	owner = get_parent()

func _on_body_entered(body: Node) -> void:
	var explosion := Explosion.instantiate()
	$/root/Main/Level.add_child(explosion)
	explosion.global_position = global_position
	queue_free()

func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	queue_free()
