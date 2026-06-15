extends Node2D
@export var cat_data: Array[CatData] = []
@onready var ui: CanvasLayer = $"../GlobalUI"
@onready var cafe_ui: VBoxContainer = $UIScreen/UI
@onready var cafe_ui2: VBoxContainer = $UIScreen/UI2
@onready var spawns: Node2D = $Spawns
signal change_scene()

func _ready() -> void:
	pass
			
func _process(float) -> void:
	pass
					
func update_cats() -> void:	
	var count = 0			
	for data in ui.cat_inventory:
		count +=1
		var new_cat = data.inside_scene.instantiate()
		new_cat.cat_data = data
		if new_cat.cat_data.inside_spot == "none":
			find_a_spot(new_cat)
		else:
			for spot in spawns.get_children():
				if new_cat.cat_data.inside_spot == spot.name:
					new_cat.global_position = spot.global_position
		var new_bar = data.happiness_bar.instantiate()
		new_bar.texture_over = data.happiness_bar_overlay
		new_cat.update_happiness_bar.connect(new_bar.update_happiness_tint)
		
		add_child(new_cat)
		if count > 5:
			cafe_ui2.add_child(new_bar)
			print(new_bar.size)
			new_bar.set_size(new_bar.size * 2)
			print(new_bar.size)
		else:
			cafe_ui.add_child(new_bar)
			print(new_bar.size)
			new_bar.set_size(new_bar.size * 2)
			print(new_bar.size)

func _on_door_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		change_scene.emit()
		
func find_a_spot(cat: CharacterBody2D):
	var possible_spots = []
	for spawn in spawns.get_children():
		if not spawn.get_meta("has_cat"):
			possible_spots.append(spawn)
	var spot = possible_spots.pick_random()
	spot.set_meta("has_cat", true)
	cat.cat_data.inside_spot = spot.name
	cat.global_position = spot.global_position
