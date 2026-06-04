class_name Game extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inside_spawn: Marker2D = $InsideSpawn
@onready var outside_spawn: Marker2D = $OutsideSpawn
@onready var inside_scene: Node2D = $Cafe
@onready var outside_scene: Node2D = $Outside
@onready var current_scene: Node2D = $Outside
@onready var white_cat_bar: TextureProgressBar = $Cafe/UI/WhiteCatBar
@onready var cafe_door: CollisionShape2D = $Cafe/Door/DoorIn
@onready var outside_door: CollisionShape2D = $Outside/Door/DoorIn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("starting outside")
	change_to_outside()
	inside_scene.change_scene.connect(_on_change_scene)
	outside_scene.change_scene.connect(_on_change_scene)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_change_scene() -> void:
	match current_scene:
		outside_scene:
			change_to_inside()
		inside_scene:
			change_to_outside()	

func change_to_outside():
	inside_scene.hide()
	cafe_door.set_deferred("disabled", true)
	outside_door.set_deferred("disabled", false)
	outside_scene.show()
	white_cat_bar.hide()
	current_scene = outside_scene
	player.global_position = outside_spawn.global_position
	
func change_to_inside():
	outside_scene.hide()
	outside_door.set_deferred("disabled", true)
	cafe_door.set_deferred("disabled", false)
	inside_scene.show()
	inside_scene.update_cats()
	white_cat_bar.show()
	current_scene = inside_scene
	player.global_position = inside_spawn.global_position
