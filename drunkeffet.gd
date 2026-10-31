extends SubViewportContainer

var mat
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = material
	GlobalManager.alcohol_level_changed.connect(on_alchohol_level_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func on_alchohol_level_changed(alcohol_level):
	if mat is ShaderMaterial and GlobalManager.alcohol_level>0.02:
		var center=mat.get_shader_parameter("center")
		#path_follow_2d.progress_ratio+=0.01*delta
		#center.y=path_follow_2d.position.y
		#center.x=path_follow_2d.position.x
		#center.y=(-GlobalManager.alcohol_level*5) + 3
		center.y=GlobalManager.alcohol_level*1.2
		print(center.y)
		mat.set_shader_parameter("center",center)
	
	
	
	
	
	
