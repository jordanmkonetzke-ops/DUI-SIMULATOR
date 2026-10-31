extends Node3D
var rotation_direction:float=1
#var rotation_direction1:float=1
#var rotation_direction2:float=1
var randTimeArray:Array[float] = [0.1,0.2,0.3,0.4,0.5,0.6,0.7]
var randFovArray:Array[float] = [30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,110,115,120,125,130,135,140,145,150,155]
var Lerpfov:float=85
var fovModifier:float=0

var i = 0 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	$SpringArm3D/Camera3D.fov=lerpf($SpringArm3D/Camera3D.fov,Lerpfov+fovModifier,1*delta)
	print(str($SpringArm3D/Camera3D.fov)+ " " + str(Lerpfov))
	print(i)
	i+=1
	if GlobalManager.alcohol_level>0.02:
		rotate(Vector3.FORWARD,GlobalManager.alcohol_level*rotation_direction/5)
		#rotate(Vector3.DOWN,GlobalManager.alcohol_level*rotation_direction1/5)
		#rotate(Vector3.LEFT,GlobalManager.alcohol_level*rotation_direction2/5)
		rotation.z = clampf(rotation.z,-deg_to_rad(35), deg_to_rad(35))
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.screen_relative.y * 0.01
		rotation.x = clampf(rotation.x,-deg_to_rad(75), deg_to_rad(75))
		rotation.y += -event.screen_relative.x * 0.01
		#var new_vector:=Vector3(event.screen_velocity.x,event.screen_velocity.y,0)
		#new_vector=new_vector.normalized()
		#rotate(new_vector,1)


func _on_timer_timeout() -> void:
	rotation_direction*=-1
	$Timer.start(randTimeArray.pick_random())


func _on_timer_2_timeout() -> void:
	if GlobalManager.alcohol_level>0.012:
		Lerpfov=randFovArray.pick_random()
	$Timer2.start(randTimeArray.pick_random())

#func _on_timer_3_timeout() -> void:
	#rotation_direction2*=-1
	#$Timer3.start(randTimeArray.pick_random())
