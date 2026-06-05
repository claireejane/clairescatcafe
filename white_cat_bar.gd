extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FillMode.FILL_LEFT_TO_RIGHT
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update_happiness_tint(happiness:float) -> void:
	self.value = happiness
	var color := color_transition.sample(happiness/100) 
	white_happiness_bar.set_tint_progress(color)
