class_name Game extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inside_spawn: Marker2D = $InsideSpawn
@onready var outside_spawn: Marker2D = $OutsideSpawn
@export var inside_scene: PackedScene
@export var outside_scene: PackedScene
@onready var current_scene: Node2D = $Outside
#@onready var white_cat_bar: TextureProgressBar = $Cafe/UI/WhiteCatBar
@onready var cafe_door: CollisionShape2D = $Cafe/Door/DoorIn
@onready var outside_door: CollisionShape2D = $Outside/Door/DoorIn


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("starting outside")
	change_to_outside()
	current_scene.change_scene.connect(_on_change_scene)

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_change_scene() -> void:
	match current_scene.name:
		"Outside":
			change_to_inside()
		"Cafe":
			change_to_outside()	

func change_to_outside():
	current_scene.change_scene.disconnect(_on_change_scene)
	remove_child(current_scene)
	current_scene = outside_scene.instantiate()
	add_child(current_scene)
	player.global_position = outside_spawn.global_position
	current_scene.change_scene.connect(_on_change_scene)
	
func change_to_inside():
	current_scene.change_scene.disconnect(_on_change_scene)
	remove_child(current_scene)
	current_scene = inside_scene.instantiate()
	add_child(current_scene)
	current_scene.update_cats()
	player.global_position = inside_spawn.global_position
	current_scene.change_scene.connect(_on_change_scene)
