extends CanvasLayer

@export var cat_inventory: Array[CatData] = []
@export var all_cats: Array[CatData] = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("open inv"):
		open_inv()
	
	
func open_inv() -> void:
	show()
	
