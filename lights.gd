extends Node2D
@export var colors: Array[Texture2D]
@export var current_skin := 0
@onready var color: Sprite2D = $Sprite2D
@onready var color2: Sprite2D = $Sprite2D2
@onready var color3: Sprite2D = $Sprite2D3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_skin = SaveData.light_skin
	set_skin(current_skin)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_skin(index):
	color.texture = colors[index]
	color2.texture = colors[index]
	color3.texture = colors[index]



func _on_click_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			current_skin = (current_skin+1)%colors.size()
			set_skin(current_skin)
			SaveData.light_skin = current_skin
				
		
