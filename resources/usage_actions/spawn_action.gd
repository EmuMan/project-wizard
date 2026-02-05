extends UsageAction
class_name SpawnAction

@export var entity_scene: PackedScene
@export var spawn_on_mouse: bool = true

func use(user: Node2D, mouse_pos: Vector2, scene_root: Node2D) -> void:
	if not entity_scene:
		return
	
	var entity = entity_scene.instantiate()
	entity.global_position = mouse_pos if spawn_on_mouse else user.global_position
	scene_root.add_child(entity)
