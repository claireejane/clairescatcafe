extends TextureProgressBar
@export var color_transition: Gradient 
@onready var warning: TextureRect = $Warning
@onready var time_on: Timer = $TimeOn
@onready var time_off: Timer = $TimeOff



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FillMode.FILL_LEFT_TO_RIGHT
	print(Vector2(position.x, position.y))
	print(visible)
	print(size)
	set_size(size*10)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_happiness_tint(happiness:float) -> void:
	self.value = happiness
	var color := color_transition.sample(happiness/100) 
	set_tint_progress(color)
	if happiness < 40:
		warning.show()
	elif happiness > 40:
		warning.hide()
	while happiness < 20:
		flash_on_off()
	
	

func flash_on_off() -> void:
	warning.show()
	time_on.start()

func _on_time_off_timeout() -> void:
	time_on.start()
	warning.show()

func _on_time_on_timeout() -> void:
	warning.hide()
	time_off.start()
