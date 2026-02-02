extends State

@export var enemy: TargetingEnemy

@export var icicle_scene: PackedScene

@export var icicle_count: int
@export var min_target: Vector2 = Vector2(-500, -300)
@export var max_target: Vector2 = Vector2(500, 300)

var has_shot: bool

func enter():
	has_shot = false

func physics_update(_delta: float):
	if has_shot:
		return
	
	var random_positions: Array[Vector2] = []
	for _i in range(icicle_count):
		var target_x = randf_range(min_target.x, max_target.x)
		var target_y = randf_range(min_target.y, max_target.y)
		var target_pos = Vector2(target_x, target_y)
		random_positions.append(target_pos)
	
	for icicle_pos in random_positions:
		var icicle = icicle_scene.instantiate()
		icicle.global_position = icicle_pos
		get_tree().current_scene.add_child(icicle)
	
	has_shot = true
	
	finished.emit("ShootState")
