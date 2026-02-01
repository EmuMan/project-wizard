extends Node


#region Global Variables

const SCENES = {
	"Inventory":	"uid://ds2qpf7hcopm3",
	# "TestLevel1":	"uid://b8a11q4oclpcq"
	"TestLevel1":	"uid://dmp7d5vqg130w"
}

var current_scene: Node = null

#endregion

func change_scene(_scene_name) -> void:
	if (!SCENES.has(_scene_name)):
		push_error("Scene '%s' could not be resolved in SceneManager dictionary" % _scene_name)
		return
	
	var _scene_path = SCENES[_scene_name]
	var _packed_scene = load(_scene_path)
	
	if (_packed_scene == null):
		push_error("Failed to load packed scene at path: '%s'" % _scene_path)
		return
	
	var _new_scene = _packed_scene.instantiate()
	
	if (current_scene):
		current_scene.queue_free()
	
	current_scene = _new_scene
	Game.Scene.add_child(current_scene)
