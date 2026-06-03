extends Control

@export var cat_data: CatData
@onready var icon: TextureRect = $Icon
@onready var ui: CanvasLayer = $ "../GlobalUI"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_found(cat_data, visible: bool) -> void:
	if (cat_data in ui.cat_inventory) and visible:
		icon.set_texture(cat_data.loaf)
		icon.show()
	icon.hide()
