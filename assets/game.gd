class_name Game extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inside_spawn: Marker2D = $InsideSpawn
@onready var outside_spawn: Marker2D = $OutsideSpawn
@onready var inside_scene: Node2D = $Cafe
@onready var outside_scene: Node2D = $Outside
@onready var current_scene: Node2D = $Outside
@onready var white_cat_bar: TextureProgressBar = $Cafe/UI/WhiteCatBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("starting outside")
	player.global_position = outside_spawn.global_position
	outside_scene.show()
	inside_scene.hide()
	white_cat_bar.hide()
	inside_scene.change_scene.connect(_on_change_scene)
	outside_scene.change_scene.connect(_on_change_scene)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_change_scene() -> void:
	match current_scene:
		outside_scene:
			outside_scene.hide()
			inside_scene.show()
			inside_scene.update_cats()
			white_cat_bar.show()
			current_scene = inside_scene
			player.global_position = inside_spawn.global_position
		inside_scene:
			inside_scene.hide()
			outside_scene.show()
			white_cat_bar.hide()
			current_scene = outside_scene
			player.global_position = outside_spawn.global_position
