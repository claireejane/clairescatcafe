extends CharacterBody2D

@export var cat_data: CatData
@export var congrats: Array[String] = []
@export var all_cats: Array[CharacterBody2D] = []

signal cat_found(cat_data: CatData)

const SPEED = 300.0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var walk: AnimatedSprite2D = $Walk
@onready var player: CharacterBody2D = $"../../Player"

@onready var idle_countdown: Timer = $IdleCountdown
@onready var idle_duration: Timer = $IdleDuration
@onready var t_popup: Timer = $PopupTime
@onready var self_destruct: Timer = $SelfDestruct
@onready var label: Label = $CanvasLayer/Label

var next_position: Vector2
var walkcycle: String = "down"
var player_near: bool = false

var game: Game
var ui: CanvasLayer
var label_congrats: Label
var label_cat_name: Label
var cafe_bonus: Label
var difficulty: Label


func _ready() -> void:
	call_deferred("setup_ui_labels")
	call_deferred("pick_new_target")

	next_position = navigation_agent.get_next_path_position()

	if cat_data:
		walk.sprite_frames = cat_data.walk


func setup_ui_labels() -> void:
	game = GameUtility.get_game()
	ui = GameUtility.get_global_ui()

	label_congrats = GameUtility.get_label("Congrats")
	label_cat_name = GameUtility.get_label("CatName")
	cafe_bonus = GameUtility.get_label("CafeBonus")
	difficulty = GameUtility.get_label("Difficulty")

	hide_text()
	label.hide()


func _physics_process(delta: float) -> void:
	if idle_duration.is_stopped():
		_move_cat()

	if Input.is_action_just_pressed("get") and player_near:
		collect_cat()
		

		
	if SaveData.cafe_progress == 100:
		print("100% complete") 
		queue_free()
		label.show()
		t_popup.wait_time = 10
		t_popup.start()
		var outside = GameUtility.get_game().find_child("Outside")
		outside.show_win_screen()
		


func collect_cat() -> void:
	if cat_data == null:
		return

	SaveData.most_recent_cat = cat_data.name

	var is_new_cat :bool = cat_data not in ui.cat_inventory

	if is_new_cat:
		show_cat_popup()

	cat_found.emit(cat_data)

	print("should have found")

	# Kill this exact cat instance.
	queue_free()


func show_cat_popup() -> void:
	var congratulations := "Congrats!"
	if congrats.size() > 0:
		congratulations = congrats.pick_random()

	label_congrats.text = congratulations
	label_cat_name.text = cat_data.name + "!"

	var percent_difficulty := 100 - cat_data.spawn_weight

	if percent_difficulty >= 98:
		difficulty.text = "- MYTHIC CAT"
	elif percent_difficulty >= 93:
		difficulty.text = "- LEGENDARY CAT"
	elif percent_difficulty >= 89:
		difficulty.text = "- RARE CAT"
	else:
		difficulty.text = "- COMMON CAT"

	cafe_bonus.text = "+" + str(cat_data.cafe_value) + "% POPULARITY BOOST"

	label_congrats.show()
	label_cat_name.show()
	cafe_bonus.show()
	difficulty.show()
	t_popup.wait_time = 8
	t_popup.start()


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body == player:
		player_near = true
		print("player near")


func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body == player:
		player_near = false
		print("player not near")


func pick_new_target() -> void:
	var random_x := randf_range(-200, 200)
	var random_y := randf_range(-200, 200)
	var target_position := global_position + Vector2(random_x, random_y)
	navigation_agent.target_position = target_position


func _move_cat() -> void:
	next_position = navigation_agent.get_next_path_position()

	var direction := global_position.direction_to(next_position)

	if abs(direction.x) > abs(direction.y):
		walkcycle = "right" if direction.x > 0 else "left"
	elif abs(direction.y) > abs(direction.x):
		walkcycle = "down" if direction.y > 0 else "up"

	if navigation_agent.is_navigation_finished():
		pick_new_target()
		return

	velocity = direction * SPEED
	move_and_slide()
	walk.play(walkcycle)


func _on_idle_countdown_timeout() -> void:
	var duration := randi_range(2, 7)
	idle_duration.wait_time = duration
	walkcycle = "idle"
	idle_duration.start()
	walk.play(walkcycle)


func _on_idle_duration_timeout() -> void:
	var duration := randi_range(2, 15)
	idle_countdown.wait_time = duration
	idle_countdown.start()


func _on_popup_time_timeout() -> void:
	hide_text()
	label.hide()


func hide_text() -> void:
	if label_congrats:
		label_congrats.hide()
	if label_cat_name:
		label_cat_name.hide()
	if cafe_bonus:
		cafe_bonus.hide()
	if difficulty:
		difficulty.hide()

func deletus() -> void:
	self_destruct.start()
	
func _on_self_destruct_timeout() -> void:
	queue_free()
