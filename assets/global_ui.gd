extends CanvasLayer

@export var cat_inventory: Array[CatData] = []
@export var is_open: bool = false
@onready var cat_slots: Control = $CatMenuPanel/CatSlotHolder
@onready var cafe_progress: TextureProgressBar = $CatMenuPanel/Control/CafeProgress
@onready var outside: Node2D = $"../Outside"
signal all_done
var done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open inv"):
		toggle_inv()
	if cat_inventory.size() >= 10 and not done :
		if SaveData.amount_changed == 0:
			pass
		done = true
		all_done.emit()
	if SaveData.cheats_on == true:
		SaveData.cheats_on = false
		add_all_cats()
		
	
	
	
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
				
func add_all_cats() -> void:
	for cat_data in outside.possible_cats:
		cat_inventory.append(cat_data)
		print("added new cat")
		SaveData.cat_amount +=1
		SaveData.cafe_progress += cat_data.cafe_value
		cafe_progress.update_cafe_tint(SaveData.cafe_progress)
		for slot in cat_slots.get_children():
			if slot.cat_data.name == cat_data.name: #for no reason this only works here when i do name??? it works when i manually find them tho??
				slot.set_found(cat_data)  #i think its bc these ones are referring to the ones in outsides array and these other ones are just pulled from the side bar? idfk
