extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func go_outside() -> void:
	self.show()

func go_inside() -> void:
	pass
