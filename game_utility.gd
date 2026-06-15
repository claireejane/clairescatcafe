class_name GameUtility #shoutout joe for this script

static func get_cat() -> Cat:
	var game := get_game()
	var timeout := 0
	var found := false
	while found == false or timeout < 50:
		for child in game.get_children():
			if child is AnimatedSprite2D:
				return child
			else: 
				timeout += 1

	assert(false, "Could not find Cat node")
	print("did not delete")
	return null
	

static func get_game() -> Game:
	var scene_tree := Engine.get_main_loop() as SceneTree
	var game := scene_tree.current_scene as Game
	assert(game, "Trying to get game at an invalid time!")
	return game
	
static func get_global_ui() -> CanvasLayer:#to get the plus one cat text
	var global_ui = get_game().find_child("GlobalUI")
	return global_ui
	
static func get_label(name: String) -> Label:
	var label = get_dialogue().find_child(name)
	return label as Label
	
static func get_outside() -> Node2D:
	var outside = get_game().find_child("Outside", true, false) as Node2D
	assert(outside != null, "couldnt get outside")
	return outside
	
static func get_dialogue() -> CanvasLayer:
	var dialogue := get_outside().find_child("Dialogue", true, false) as CanvasLayer
	assert(dialogue != null, "Could not find Dialogue")
	return dialogue
