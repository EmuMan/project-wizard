extends State

@export var enemy: TargetingEnemy

@export var bullet_scene: PackedScene

@export var warmup_time: float = 2.0
@export var shot_count_max: int = 1
@export var shot_count_min: int = 1
@export var time_between_shots: float = 1.0

@export var no_target_state_name: String = "IdleState"
@export var next_state_name: String

var warmup_timer: float = 0.0
var cooldown_timer: float = 0.0
var shot_limit: int
var shot_count: int

func enter():
	warmup_timer = 0.0
	# start shooting instantly after warmup
	cooldown_timer = time_between_shots
	shot_limit = randi_range(shot_count_min, shot_count_max)
	shot_count = 0

func physics_update(delta: float):
	if shot_count == 0:
		warmup_timer += delta
		if warmup_timer < warmup_time:
			return
	
	if shot_count >= shot_limit:
		finished.emit(next_state_name)
		return
	
	cooldown_timer += delta
	if cooldown_timer < time_between_shots:
		return
	
	enemy.find_new_target()
	
	if not enemy.target:
		finished.emit(no_target_state_name)
		return
	
	var bullet = bullet_scene.instantiate()
	bullet.init_bullet(global_position, enemy.target.global_position)
	get_tree().current_scene.add_child(bullet)
	
	cooldown_timer = 0.0
	shot_count += 1
