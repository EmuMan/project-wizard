extends Node


#region Global Variables

const SCENES = {
	"Inventory":	"uid://ds2qpf7hcopm3",
	"Level1":	"uid://b8a11q4oclpcq",
	"Level2":	"uid://dmp7d5vqg130w",
	"Level3":	"uid://cgbxf12fs05cn"
}
var current_scene: Node = null
var current_scene_name: String = ""

#endregion

func change_scene(scene_name: String) -> void:
	if (!SCENES.has(scene_name)):
		push_error("Scene '%s' could not be resolved in SceneManager dictionary" % scene_name)
		return

	var scene_path = SCENES[scene_name]
	var packed_scene = load(scene_path)

	if (packed_scene == null):
		push_error("Failed to load packed scene at path: '%s'" % scene_path)
		return

	current_scene = null
	current_scene_name = scene_name
	get_tree().change_scene_to_packed(packed_scene)
	
	await get_tree().scene_changed
	
	current_scene = get_tree().current_scene
