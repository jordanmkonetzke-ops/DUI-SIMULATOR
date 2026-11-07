extends RigidBody3D
@onready var car_mesh: Node3D = $suv2
@onready var body_mesh: Node3D = $suv2/suv
@onready var ground_ray: RayCast3D = $suv2/RayCast3D
@onready var right_wheel: MeshInstance3D =$"suv2/suv/wheel-front-right"
@onready var left_wheel: MeshInstance3D = $"suv2/suv/wheel-front-left"

@onready var area_light_3d_winshield: AreaLight3D = $suv2/suv/body/AreaLight3D_winshield
@onready var area_light_3d_back: AreaLight3D = $suv2/suv/body/AreaLight3D_back
@onready var area_light_3d_leftwindow: AreaLight3D = $suv2/suv/body/AreaLight3D_leftwindow
@onready var spot_light_3d_leftheadlight: SpotLight3D = $suv2/suv/body/SpotLight3D_leftheadlight
@onready var spot_light_3d_rightheadlight: SpotLight3D = $suv2/suv/body/SpotLight3D_rightheadlight
@onready var area_light_3d_rightwindow: AreaLight3D = $suv2/suv/body/AreaLight3D_rightwindow
@onready var spot_light_3d_leftheadlight2: SpotLight3D = $suv2/suv/body/SpotLight3D_leftheadlight2
@onready var spot_light_3d_rightheadlight2: SpotLight3D = $suv2/suv/body/SpotLight3D_rightheadlight2

var sphere_offset=Vector3.DOWN
var acceleration=35.0
var steering=18.0
var turn_speed=8.0
var turn_stop_limit=0.75
var speed_input=0
var turn_input=0
var body_tilt = -70
var fovspeed=0
var drivemessup=0.08
var acceleratecontrol: String= "accelerate"
var brakecontrol: String= "brake"
var turnleftcontrol: String= "turn left"
var turnrightcontrol: String= "turn right"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalManager.alcohol_level_changed.connect(drunkeffects)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var temp = abs(linear_velocity)/2
	fovspeed=lerpf(fovspeed,temp.x+temp.z,0.1)
	if not ground_ray.is_colliding():
		return
		

	speed_input = Input.get_axis(acceleratecontrol,brakecontrol)*acceleration
	turn_input = Input.get_axis(turnrightcontrol,turnleftcontrol)*deg_to_rad(steering)
	right_wheel.rotation.y = turn_input
	left_wheel.rotation.y = turn_input
	$"suv2/camera pivot".fovModifier=clampf(fovspeed,0,50)
		
	
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
	
	#this turns carlight on and off at certin times
	if range(0,6).has(GlobalManager.timeofday) or range(17,24).has(GlobalManager.timeofday):
		spot_light_3d_leftheadlight.visible=true
		spot_light_3d_leftheadlight2.visible=true
		spot_light_3d_rightheadlight2.visible=true
		spot_light_3d_rightheadlight.visible=true
		area_light_3d_winshield.visible=true
		area_light_3d_back.visible=true
		area_light_3d_leftwindow.visible=true
		area_light_3d_rightwindow.visible=true
		#   ^
		#on |
	else:
		spot_light_3d_leftheadlight.visible=false
		spot_light_3d_leftheadlight2.visible=false
		spot_light_3d_rightheadlight2.visible=false
		spot_light_3d_rightheadlight.visible=false
		area_light_3d_winshield.visible=false
		area_light_3d_back.visible=false
		area_light_3d_leftwindow.visible=false
		area_light_3d_rightwindow.visible=false
		#    ^
		#off |
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
	
func drunkeffects(alcohol_level: float):
	var randomControlArray:Array=["brake","turn left","turn right","accelerate"]
	randomControlArray.shuffle()
	if alcohol_level>=drivemessup+0.01:
		acceleratecontrol= randomControlArray.pop_front()
		brakecontrol= randomControlArray.pop_front()
		turnleftcontrol= randomControlArray.pop_front()
		turnrightcontrol= randomControlArray.pop_front()
	
	
	
	
