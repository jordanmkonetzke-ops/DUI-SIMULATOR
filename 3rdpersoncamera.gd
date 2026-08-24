extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode =Input.MOUSE_MODE_CAPTURED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.x -= event.screen_relative.y * 0.01
		rotation.x = clampf(rotation.x,-deg_to_rad(75), deg_to_rad(75))
		rotation.y += -event.screen_relative.x * 0.01
		#var new_vector:=Vector3(event.screen_velocity.x,event.screen_velocity.y,0)
		#new_vector=new_vector.normalized()
		#rotate(new_vector,1)
