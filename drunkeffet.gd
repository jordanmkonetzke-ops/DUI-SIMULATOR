extends SubViewportContainer

var mat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mat = material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mat is ShaderMaterial:
		var center=mat.get_shader_parameter("center")
		center.y +=0.001
		mat.set_shader_parameter("center",center)
