extends Node3D
const COCKTAIL = preload("uid://o7xhr4mclnyr")
const GLASS_WINE = preload("uid://b717mt264uux4")
const SODA_BOTTLE = preload("uid://dtstj15dukqcb")
const SODA_CAN = preload("uid://pu7b0g6wnuj2")
const SODA_GLASS = preload("uid://dq37qnb6dc3n0")
const WINE_WHITE = preload("uid://dgg7u0e464sbv")
const WINE_RED = preload("uid://oye1cudmo0k5")
@onready var pivot: Node3D = $pivot

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
