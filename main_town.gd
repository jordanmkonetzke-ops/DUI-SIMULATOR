extends Node3D
@onready var time_of_day: TimeOfDay = $Sky3D/TimeOfDay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalManager.timeofday=floori(time_of_day.current_time)
	GlobalManager.alcohol_level_changed.connect(drunkeffects)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_time_of_day_hour_changed(value: Variant) -> void:
	GlobalManager.timeofday=value
func drunkeffects(alcohol_level: float):
	if alcohol_level>=0.02:
		$drunkeffet.visible=true
		
	
