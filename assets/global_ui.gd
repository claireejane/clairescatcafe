extends CanvasLayer

@export var cat_inventory: Array[CatData] = []
@export var all_cats: Array[CatData] = []
@export var is_open: bool = false
@onready var cat_slots: Control = $CatMenuPanel/CatSlotHolder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open inv"):
		toggle_inv()
	
	
	
func toggle_inv() -> void:
	if not is_open:
		show()
		is_open = true
	else: 
		hide()
		is_open = false
	
func on_cat_found(found_cat_data: CatData) -> void:
	if found_cat_data not in cat_inventory:
		cat_inventory.append(found_cat_data)
		print("added new cat")
		print(found_cat_data.name)
		for slot in cat_slots.get_children():
			if slot.cat_data == found_cat_data:
				slot.set_found(found_cat_data)
	
