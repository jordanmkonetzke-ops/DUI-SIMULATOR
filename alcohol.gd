extends Node3D
const COCKTAIL = preload("uid://o7xhr4mclnyr")
const GLASS_WINE = preload("uid://b717mt264uux4")
const SODA_BOTTLE = preload("uid://dtstj15dukqcb")
const SODA_CAN = preload("uid://pu7b0g6wnuj2")
const SODA_GLASS = preload("uid://dq37qnb6dc3n0")
const WINE_WHITE = preload("uid://dgg7u0e464sbv")
const WINE_RED = preload("uid://oye1cudmo0k5")
@onready var pivot: Node3D = $pivot

const DOUBLE_SHLORP = preload("uid://bkf4f5s840tcq")
const HALO_SHLORPER = preload("uid://vdrqdkknfa67")
const OVER_SHLORP = preload("uid://dkebp6ii8x32p")
const SHLOR_BLAST = preload("uid://cd3t0yaris662")
const SHLORP = preload("uid://csdlxn561t5vx")
const SHLORP_APOCALYPSE = preload("uid://cdck15wcadpfx")
const SHLORP_BILLONARE = preload("uid://dyuqs88drtsn2")
const SHLORPFINITY = preload("uid://cfj4kxe81si3v")
const SHLORPIMANJARO = preload("uid://d0llhq3hwuwxw")
const SHLORP_JYNXIZ = preload("uid://cr0fan2cn5i21")
const SHLORP_TACULAR = preload("uid://s8pg5geeko4d")
const SHLORP_TROCITY = preload("uid://dppijodw82wg6")
const SUPER_SHLORPER = preload("uid://caoyqms5sdopd")
const TRIPLE_SHLORP = preload("uid://cbpx1ylsfjwsn")



var itemarray: Array[Resource]=[
	COCKTAIL,
	GLASS_WINE,
	WINE_RED,
	WINE_WHITE,
	SODA_BOTTLE,
	SODA_CAN,
	SODA_GLASS
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_item = itemarray.pick_random().instantiate()
	$Sprite3D.visible=false
	pivot.add_child(new_item)
	new_item.scale*=2.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	GlobalManager.alcohol_level+=1
	GlobalManager.alcohol_combo+=1
	GlobalManager.alcohol_reset_combo_timer.stop()
	GlobalManager.alcohol_reset_combo_timer.start(5.0)
	
	match GlobalManager.alcohol_combo:#TODO: fix sound queue in aduio manager
		1: 
			AudioManager.add_sound_to_queue(SHLORP)
		2:
			AudioManager.stream=DOUBLE_SHLORP
			AudioManager.play()
		3:
			AudioManager.stream=TRIPLE_SHLORP
			AudioManager.play()
		4:
			AudioManager.stream=OVER_SHLORP
			AudioManager.play()
		5:
			AudioManager.stream=SHLORP_TACULAR
			AudioManager.play()
		6:
			AudioManager.stream=SHLORP_TROCITY
			AudioManager.play()
		7:
			AudioManager.stream=SHLORPIMANJARO
			AudioManager.play()
		8:
			AudioManager.stream=SUPER_SHLORPER
			AudioManager.play()
		9:
			AudioManager.stream=SHLORP_APOCALYPSE
			AudioManager.play()
		10:
			AudioManager.stream=SHLORP_BILLONARE
			AudioManager.play()
		11:
			AudioManager.stream=SHLOR_BLAST
			AudioManager.play()
		12:
			AudioManager.stream=SHLORP_JYNXIZ
			AudioManager.play()
		13:
			AudioManager.stream=SHLORPFINITY
			AudioManager.play()
		14:
			AudioManager.stream=HALO_SHLORPER
			AudioManager.play()
		_:
			AudioManager.stream=SHLORP
			AudioManager.play()

		
	queue_free()
