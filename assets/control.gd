extends TextureProgressBar
@export var color_transition: Gradient 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FillMode.FILL_LEFT_TO_RIGHT
	print(Vector2(position.x, position.y))
	print(visible)
	print(size)
	set_size(size*10)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var progress = SaveData.cafe_progress
	update_cafe_tint(progress)
	
func update_cafe_tint(cafe_total:float) -> void:
	self.value = cafe_total
	var color := color_transition.sample(cafe_total/100) 
	set_tint_progress(color)
