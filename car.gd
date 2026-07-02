extends CharacterBody3D

@export var acceleration:float=25.0
@export var gravity:float=9.8

var target_velocity:=Vector3.ZERO
var jump_power=20
func _physics_process(delta: float) -> void:
	var movement_vector:= Input.get_vector("move right","move left","backwards","forwards")
	var turning_float:= Input.get_axis("turn right","turn left")
	rotate_y(turning_float)

	
	if Input.is_action_pressed("jump") and is_on_floor():
		target_velocity.y=acceleration*delta*jump_power
	
	if movement_vector != Vector2.ZERO:
		target_velocity += movement_vector.x * acceleration * delta * transform.basis.x
		target_velocity += movement_vector.y * acceleration * delta * transform.basis.z
		
	if is_on_floor():
		target_velocity*=0.97
		
	
	# check if we should move down with gravity or not
	if is_on_floor()!=true:
		target_velocity.y = target_velocity.y-(gravity*delta)
	#var basis = transform.basis
	
	
	#set charter body velocity and move and slide
	velocity=target_velocity
	move_and_slide()
	
