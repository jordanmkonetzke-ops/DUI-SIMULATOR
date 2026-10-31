extends AudioStreamPlayer
var audio_queue:Array=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finished() -> void:
	if !audio_queue.is_empty():
		stream=audio_queue.pop_back()
		play()

func add_sound_to_queue(sound):
	if !audio_queue.is_empty() or playing:
		print("added this sound to queue:" + str(sound))
		audio_queue.push_front(sound)
	else:
		stream=sound
		play()
		
		
		
		
		
		
		
		
		
		
