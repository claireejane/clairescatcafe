extends Node2D


@export var possible_cats: Array[CatData] = []
@export var all_cats: Array[CharacterBody2D] = []
@onready var spawns: Node2D = $Spawns
@onready var timer: Timer = $CatTimer
@onready var ui: CanvasLayer = $ "../GlobalUI"
signal change_scene()
@onready var dialogue: CanvasLayer = $Dialogue
@onready var win_screen: AnimatedSprite2D = $Dialogue/WinScreen
@onready var v_box_container: VBoxContainer = $Dialogue/VBoxContainer
@onready var win_text: Label = $Dialogue/WinText



func _ready() -> void:
	timer.start()
	win_screen.hide() 
	
func _process(float) -> void:
	if Input.is_action_just_pressed("g")	:
		delete_all_cats()
		v_box_container.hide()
		dialogue.show()
		win_screen.show()
		win_screen.play("default")
		win_text.shoW()
		

		
func _spawn_cat() -> void: 
	var chosen_cat_data: CatData = _pick_cat()
	print(chosen_cat_data.name)
	print(chosen_cat_data.outside_scene)
	var new_cat = chosen_cat_data.outside_scene.instantiate()
	new_cat.cat_data = chosen_cat_data
	new_cat.cat_found.connect(ui.on_cat_found) #when this spawned cat does cat_found, call on_cat_found)
	new_cat.cat_found.connect(dialogue.on_cat_found) ##what esle i gotta connect
	ui.all_done.connect(delete_all_cats)
	var spawn_point = spawns.get_children().pick_random()
	add_child(new_cat)
	all_cats.append(new_cat)
	
	SaveData.cat_amount += 1
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
	if visible: _spawn_cat()
	
func _on_door_body_entered(body: Node2D) -> void:
	
	
	if body.name == "Player":
		change_scene.emit()
		
		
func delete_all_cats() -> void:
	for cat in all_cats:
		if is_instance_valid(cat):
			cat.queue_free()

	all_cats.clear()
		

func show_win_screen() -> void:
	v_box_container.hide()
	dialogue.show()
	win_screen.show()
	win_screen.play("default")
	win_text.show()
