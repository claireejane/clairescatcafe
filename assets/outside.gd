extends Node2D


@export var cat_data: Array[CatData] = []


func _ready() -> void:
	for data in cat_data:
		var new_cat = data.scene.instantiate()
		add_child(new_cat)
