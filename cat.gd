extends CharacterBody2D

@export var cat_data: CatData
@onready var needs: Array[String] = ["water", "love", "play", "food"]
var current_need
var needs_generated := false
@onready var animated_sprite = $CatBubble
@onready var white_happiness_bar = %WhiteCatBar
@onready var sprite = $Sprite2D
@export var happiness : float = cat_data.starting_happiness


func _ready() -> void:
	
	animated_sprite.hide()
	$ClickArea.input_event.connect(_on_click_area_input_event)
	animated_sprite.animation_finished.connect(_on_cat_bubble_animation_finished)
	if cat_data:
		sprite.texture = cat_data.loaf

func _on_click_area_input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and happiness < 75:
			happiness = 100
			animated_sprite.hide()
			current_need = ""
			needs_generated = false

func _process(delta: float) -> void:
	var difficulty = (100 - cat_data.spawn_weight)*0.1
	happiness -= delta * difficulty
	update_happiness_bar()
	if happiness < 75 and needs_generated == false:
		animated_sprite.show()
		animated_sprite.play("generate")
		needs_generated = true
		current_need = needs.pick_random()

func _on_cat_bubble_animation_finished() -> void:
	if animated_sprite.animation == "generate":
		animated_sprite.play(current_need)	
		
func update_happiness_bar() -> void:
	white_happiness_bar.value = happiness
	var green = 0 + happiness/100
	var red = 1 - happiness / 100
	white_happiness_bar.set_tint_progress(Color(red, green, 0))
