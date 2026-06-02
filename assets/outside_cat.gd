extends CharacterBody2D

@export var cat_data: CatData

@onready var navigation_agent = $NavigationAgent2D
@onready var next_position
@onready var sprite: Sprite2D = $Loaf

const SPEED = 300.0
var player_near : bool = false


func _ready() -> void:
	call_deferred("pick_new_target")
	next_position = navigation_agent.get_next_path_position()
	if cat_data:
		sprite.set_texture(cat_data.loaf)
	
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(next_position)
	if navigation_agent.is_navigation_finished():
		pick_new_target()
		return
	else:
		velocity = direction * SPEED
		move_and_slide()
	if Input.is_action_just_pressed("get") and player_near == true:
		self.hide()
	next_position = navigation_agent.get_next_path_position()

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if player_near == true:
		player_near = false


func _on_interaction_area_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if player_near == false:
		player_near = true

func pick_new_target() -> void:
	var random_x = randf_range(-200, 200)
	var random_y = randf_range(-200, 200)
	var target_position = global_position + Vector2(random_x, random_y)
	navigation_agent.target_position = target_position
