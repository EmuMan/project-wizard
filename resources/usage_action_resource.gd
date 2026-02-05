extends Resource
class_name UsageAction

@export var cooldown_duration: float = 0.0
@export var start_charged: bool = false

func use(_user: Node2D, _mouse_pos: Vector2, _scene_root: Node2D) -> void:
	pass # Override in subclasses
