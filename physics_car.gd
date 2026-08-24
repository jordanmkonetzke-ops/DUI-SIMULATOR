extends RigidBody3D

var target_angular_acceleration:=Vector3.ZERO
var target_linear_acceleration:=Vector3.ZERO
var max_speed:=Vector3(50.0,50.0,50.0)
var engine_power: = 2000000.0
var realDampAngular: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	realDampAngular = angular_damp

func _process(delta: float) -> void:
	if Input.is_action_pressed("drift"):
		angular_damp = 0.0
	else:
		angular_damp = realDampAngular

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	target_linear_acceleration=Vector3.ZERO
	target_angular_acceleration=Vector3.ZERO
	
	target_linear_acceleration += Input.get_axis("backwards","forwards") * engine_power * transform.basis.z
	target_angular_acceleration += Input.get_axis("turn right","turn left") * engine_power/5 * transform.basis.y
	print(target_linear_acceleration)
	print(target_angular_acceleration)
	
	apply_torque(target_angular_acceleration)
	apply_central_force(target_linear_acceleration)
	

	if abs(linear_velocity.x) > max_speed.x:
		if linear_velocity.x < 0:
			linear_velocity.x = max_speed.x * -1
		else:
			linear_velocity.x = max_speed.x
			
	if abs(linear_velocity.y) > max_speed.y:
		if linear_velocity.y < 0:
			linear_velocity.y = max_speed.y * -1
		else:
			linear_velocity.y = max_speed.y
			
	if abs(linear_velocity.z) > max_speed.z:
		if linear_velocity.z < 0:
			linear_velocity.z = max_speed.z * -1
		else:
			linear_velocity.z = max_speed.z
