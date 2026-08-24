extends RigidBody3D
@onready var car_mesh: Node3D = $suv2
@onready var body_mesh: Node3D = $suv2/suv
@onready var ground_ray: RayCast3D = $suv2/RayCast3D
@onready var right_wheel: MeshInstance3D =$"suv2/suv/wheel-front-right"
@onready var left_wheel: MeshInstance3D = $"suv2/suv/wheel-front-left"

var sphere_offset=Vector3.DOWN
var acceleration=35.0
var steering=18.0
var turn_speed=4.0
var turn_stop_limit=0.75
var speed_input=0
var turn_input=0
var body_tilt = -35
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not ground_ray.is_colliding():
		return
	speed_input = Input.get_axis("accelerate","brake")*acceleration
	turn_input = Input.get_axis("turn right","turn left")*deg_to_rad(steering)
	right_wheel.rotation.y = turn_input
	left_wheel.rotation.y = turn_input
	
	if linear_velocity.length()>turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, turn_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
		var t = -turn_input * linear_velocity.length() / body_tilt
		body_mesh.rotation.y = lerp(body_mesh.rotation.y, t, 10 * delta)
		
	if ground_ray.is_colliding():
		var n = ground_ray.get_collision_normal()
		var xform = align_with_y(car_mesh.global_transform, n)
		car_mesh.global_transform = car_mesh.global_transform.interpolate_with(xform, 10.0 * delta)
	
	#var t = -turn_input * linear_velocity.length() / body_tilt
	#body_mesh.rotation.z = lerp(body_mesh.rotation.z, t, 100 * delta)
func _physics_process(delta: float) -> void:
	car_mesh.global_position = global_position + sphere_offset
	if ground_ray.is_colliding() and abs(speed_input) > 0:
		apply_central_force(-car_mesh.global_transform.basis.z * speed_input)
	elif ground_ray.is_colliding() and abs(speed_input) == 0:
		apply_central_force(-linear_velocity*3)
		
	
func align_with_y(xform, new_y):
	xform.basis.y = new_y
	xform.basis.x = -xform.basis.z.cross(new_y)
	xform.basis = xform.basis.orthonormalized()
	return xform
	
	
	
	
	
