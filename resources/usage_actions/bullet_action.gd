extends UsageAction
class_name BulletAction

@export var bullet_scene: PackedScene

func use(user: Node2D, mouse_pos: Vector2, scene_root: Node2D) -> void:
	if not bullet_scene:
		return
	
	var bullet = bullet_scene.instantiate()
	bullet.init_bullet(user.global_position, mouse_pos)
	scene_root.add_child(bullet)
