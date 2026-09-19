extends Node

var alcohol_level:float=0.0
var alcohol_reset_combo_timer:Timer=Timer.new()
var alcohol_combo:int=0



func _ready() -> void:
	add_child(alcohol_reset_combo_timer)
	alcohol_reset_combo_timer.timeout.connect(reset_alcohol_combo)
	alcohol_reset_combo_timer.one_shot=true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset_alcohol_combo():
	alcohol_combo=0
	
