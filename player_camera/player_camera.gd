extends Camera3D

@export var offset: Vector3
@export var follow_speed: float = 2

var target_position: Vector3 = Vector3.ZERO

func reset() -> void:
	var player = %Level/%Player
	target_position = player.get_camera_target().global_position

func _ready():
	process_priority = 10

func _process(delta):
	var player = %Level/%Player
	if player == null:
		return

	target_position = target_position.lerp(player.get_camera_target().global_position, delta * follow_speed)
	global_position = target_position + offset
