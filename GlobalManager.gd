extends Node
signal alcohol_level_changed(new_alcohol_level: float)

var alcohol_level:float=0.0:
	set(value):
		if alcohol_level != value:
			alcohol_level = value
			emit_signal("alcohol_level_changed", alcohol_level)
			
var alcohol_reset_combo_timer:Timer=Timer.new()
var alcohol_combo:int=0

var timeofday



func _ready() -> void:
	add_child(alcohol_reset_combo_timer)
	alcohol_reset_combo_timer.timeout.connect(reset_alcohol_combo)
	alcohol_reset_combo_timer.one_shot=true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_alcohol_combo():
	alcohol_combo=0
	
