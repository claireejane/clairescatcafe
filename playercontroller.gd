extends CharacterBody2D

@export var speed = 200
@onready var animated_sprite = $PlayerAnimation
var scene_path

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func _physics_process(delta: float):
	get_input()
	move_and_slide()
	if Input.is_action_pressed("left"):
		animated_sprite.play("left")
	elif Input.is_action_pressed("right"):
		animated_sprite.play("right")
	elif Input.is_action_pressed("up"):
		animated_sprite.play("up")
	elif Input.is_action_pressed("down"):
		animated_sprite.play("down")
	else: animated_sprite.stop()
	

		

func _on_door_body_entered(body: Node2D) -> void:
	print(get_tree().current_scene.name)
	if get_tree().current_scene.name == "Outside":
		scene_path = "res://" + "cafe.tscn"
	elif get_tree().current_scene.name == "Cafe":
		scene_path = "res://" + "/assets/outside.tscn"
		print(scene_path)
	get_tree().call_deferred("change_scene_to_file", scene_path)		
		
