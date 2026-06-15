extends StaticBody2D
@export var colors: Array[Texture2D]
@export var current_skin := 0
@onready var color: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_skin = SaveData.food_skin
	set_skin(current_skin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_skin(index):
	color.texture = colors[index]


func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			current_skin = (current_skin+1)%colors.size()
			set_skin(current_skin)
			SaveData.food_skin = current_skin
			SaveData.amount_changed += 1
				
		
