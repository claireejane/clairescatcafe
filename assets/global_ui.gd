extends CanvasLayer

@export var cat_inventory: Array[CatData] = []
@export var is_open: bool = false
@onready var cat_slots: Control = $CatMenuPanel/CatSlotHolder
@onready var cafe_progress: TextureProgressBar = $CatMenuPanel/Control/CafeProgress
signal all_done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open inv"):
		toggle_inv()
	if cat_inventory.size() >= 10:
		all_done.emit()
	
	
	
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
		SaveData.cat_amount+=1
		SaveData.cafe_progress+= found_cat_data.cafe_value
		cafe_progress.update_cafe_tint(SaveData.cafe_progress)
		print(found_cat_data.name)
		for slot in cat_slots.get_children():
			if slot.cat_data == found_cat_data:
				slot.set_found(found_cat_data)
	
