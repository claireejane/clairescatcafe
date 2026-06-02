extends Node2D


@export var possible_cats: Array[CatData] = []
@onready var spawn_points: Array[Marker2D] = [$Spawn1, $Spawn2, $Spawn3]
@onready var timer: Timer = $CatTimer

func _ready() -> void:
	timer.start()
		
func _spawn_cat() -> void: 
	var chosen_cat_data: CatData = _pick_cat()
	print(chosen_cat_data.name)
	print(chosen_cat_data.outside_scene)
	var new_cat = chosen_cat_data.outside_scene.instantiate()
	new_cat.cat_data = chosen_cat_data
	var spawn_point = spawn_points.pick_random()
	add_child(new_cat)
	new_cat.global_position = spawn_point.global_position
	
func _pick_cat() -> CatData:
	var chosen = randi_range(1, 100)
	var lucky_range := 0
	for data in possible_cats:
		lucky_range += data.spawn_weight
		if chosen <= lucky_range:
			return data
	return possible_cats.pick_random()	
		
func _on_cat_timer_timeout() -> void:
	_spawn_cat()
