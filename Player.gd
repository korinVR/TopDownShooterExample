extends RigidBody3D

const SPEED = 5.0
const ACCELERATION = 2000000.0

var angle := 0.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var stick := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(stick.x, 0, stick.y)).normalized()
	if direction:
		apply_force(direction * ACCELERATION)
		
		var target_angle := atan2(-stick.y, stick.x)
		angle = lerp_angle(angle, target_angle, 0.1)
		$Model.rotation = Vector3(0, angle, 0)
	
