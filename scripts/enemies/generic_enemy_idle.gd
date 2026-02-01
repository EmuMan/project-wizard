extends State

@export var enemy: TargetingEnemy

@export var target_radius: float = 1_000.0

@export var next_state_name: String

func physics_update(_delta: float):
	enemy.find_new_target()
	
	if not enemy.target:
		return
	
	var dist = enemy.global_position.distance_squared_to(enemy.target.global_position)
	if dist <= target_radius ** 2:
		finished.emit(next_state_name)
