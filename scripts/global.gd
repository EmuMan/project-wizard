extends Node


#region Core Scene Variables

var current_scene: Node = null
var Music
var SFX
var Scene
var UI
var Transition
var App

#endregion

var level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Even if scene tree is paused ALWAYS run the game
	process_mode = PROCESS_MODE_ALWAYS
	# Retrieves main "App" node
	App = get_tree().root.get_node("App")
	# Get relevant child nodes in main "App" node
	Scene = App.get_child(0)
	# Starting scene is splash logo screen
	SceneManager.change_scene("Inventory")
