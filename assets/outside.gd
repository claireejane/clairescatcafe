extends Node2D


@export var possible_cats: Array[CatData] = []


func _ready() -> void:
	pass
		
func _spawn_cat() -> void: 
	var chosen_cat_data: CatData = _pick_cat()
	var new_cat = chosen_cat_data.outside_scene.instantiate()
	new_cat.cat_data = chosen_cat_data
	add_child(new_cat)	

func _pick_cat() -> CatData:
	var chosen = randi_range(1, 100)
	var lucky_range := 0
	for data in possible_cats:
		lucky_range += data.spawn_weight
		if chosen <= lucky_range:
			return data
	return possible_cats.pick_random()	
		
