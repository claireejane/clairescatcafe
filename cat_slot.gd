extends Control

@export var cat_data: CatData
@onready var icon: TextureRect = $Icon
@onready var ui: CanvasLayer = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon.hide()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_found(cat_data) -> void:
	if (cat_data in ui.cat_inventory):
		icon.set_texture(cat_data.loaf)
		icon.show()
		print("showing in inv")
	
