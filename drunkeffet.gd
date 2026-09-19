extends SubViewportContainer

var mat
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mat is ShaderMaterial:
		var center=mat.get_shader_parameter("center")
		path_follow_2d.progress_ratio+=0.01*delta
		center.y=path_follow_2d.position.y
		center.x=path_follow_2d.position.x
		print(center)
		mat.set_shader_parameter("center",center)
	
