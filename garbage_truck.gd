#based off of https://kidscancode.org/godot_recipes/4.x/3d/3d_sphere_car/index.html
extends RigidBody3D

@onready var car_mesh: Node3D = $"garbage-truck"
@onready var body_mesh: MeshInstance3D = $"garbage-truck/body"
@onready var ground_ray: RayCast3D = $"garbage-truck/RayCast3D"
@onready var left_wheel: MeshInstance3D = $"garbage-truck/wheel-front-left"
@onready var right_wheel: MeshInstance3D = $"garbage-truck/wheel-front-right"

# Where to place the car mesh relative to the sphere
var sphere_offset = Vector3.DOWN
# Engine power
var acceleration = 35.0
# Turn amount, in degrees
var steering = 18.0
# How quickly the car turns
var turn_speed = 4.0
# Below this speed, the car doesn't turn
var turn_stop_limit = 0.75

# Variables for input values
var speed_input = 0
var turn_input = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	car_mesh.position = position + sphere_offset
	if ground_ray.is_colliding():
		apply_central_force(-car_mesh.global_transform.basis.z * speed_input)

func _process(delta):
	if not ground_ray.is_colliding():
		return
	speed_input = Input.get_axis("backwards", "forwards") * acceleration
	turn_input = Input.get_axis("turn right", "turn left") * deg_to_rad(steering)
	left_wheel.rotation.y = turn_input
	right_wheel.rotation.y = turn_input
	
	if linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, turn_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()
	
	
	
	
	
	
	
