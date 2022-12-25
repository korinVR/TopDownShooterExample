extends RigidBody3D

const MyShot: PackedScene = preload("res://myshot/myshot.tscn")

const SPEED = 5.0
const ACCELERATION = 2000000.0

var angle := -PI / 2

func _ready() -> void:
	owner = get_parent()
	set_unique_name_in_owner(true)

func _physics_process(delta: float) -> void:
	var stick := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(stick.x, 0, stick.y)).normalized()
	if direction:
		apply_force(direction * ACCELERATION)
		
		var target_angle := atan2(stick.y, stick.x)
		angle = lerp_angle(angle, target_angle, 0.1)
		$Model.rotation = Vector3(0, -PI / 2 - angle, 0)
	
	if Input.is_action_just_pressed("Fire"):
		var my_shot := MyShot.instantiate() as RigidBody3D
		get_parent().add_child(my_shot)
		my_shot.global_transform = $Model/MyShotSpawnPosition.global_transform
		
		var forward := Vector3(cos(angle), 0, sin(angle))
		my_shot.linear_velocity = linear_velocity + forward * 100
	
	($CameraTarget as Node3D).position = linear_velocity * 0.8

func get_camera_target() -> Node3D:
	return $CameraTarget

func _on_body_entered(body: Node) -> void:
	var collision := body as CollisionObject3D
	if collision.get_collision_layer_value(9):
		queue_free()
