extends Node2D


@export var cat_data: Array[CatData] = []
@onready var ui: CanvasLayer = $"../GlobalUI"
@onready var cafe_ui: HFlowContainer = $UIScreen/UI
@onready var spawns: Node2D = $Spawns
signal change_scene()

func _ready() -> void:
	pass
			
func _process(float) -> void:
	pass
					
func update_cats() -> void:				
	for data in ui.cat_inventory:
		var new_cat = data.inside_scene.instantiate()
		new_cat.cat_data = data
		var new_bar = data.happiness_bar.instantiate()
		new_bar.texture_over = data.happiness_bar_overlay
		new_cat.update_happiness_bar.connect(new_bar.update_happiness_tint)
		add_child(new_cat)
		cafe_ui.add_child(new_bar)
		if new_cat.cat_data.inside_spot == "none":
			find_a_spot(new_cat)

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
