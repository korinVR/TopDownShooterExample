extends Camera3D

@export var offset: Vector3
@export var follow_speed: float = 2

var target_position: Vector3 = Vector3.ZERO

func _ready():
	process_priority = 10

func _process(delta):
	var player_camera_targets := get_tree().get_nodes_in_group("player_camera_target")
	if player_camera_targets.size() == 0:
		return
	
	target_position = target_position.lerp(player_camera_targets[0].global_position, delta * follow_speed)
	global_position = target_position + offset
