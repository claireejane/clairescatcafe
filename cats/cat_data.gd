class_name CatData
extends Resource

@export var name: String
@export var breed: String
@export var description: String

@export var loaf: Texture2D
@export var happiness_bar_overlay: Texture2D
@export var outside_scene: PackedScene
@export var inside_scene: PackedScene
@export var happiness_bar: PackedScene
@export var inside_spot: String = "none"

@export var spawn_weight: int # How rare the cat's spawn is
@export var cafe_value: int
@export var starting_happiness: float = 100.0
