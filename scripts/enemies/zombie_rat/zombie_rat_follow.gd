extends State

@export var enemy: TargetingEnemy

@export var move_speed: float = 100.0
@export var turn_speed: float = 10.0
@export var forget_radius: float = 1_000.0
@export var distance_kept: float = 100.0


func physics_update(delta: float):
	if not enemy.target:
		finished.emit("IdleState")
		return
	
	var disp_to_target = enemy.target.global_position - enemy.global_position
	var dist_to_target = disp_to_target.length_squared()
	if dist_to_target >= forget_radius ** 2:
		finished.emit("IdleState")
		return
	if dist_to_target <= distance_kept ** 2:
		finished.emit("ShootState")
		return
	
	var dir_to_target = disp_to_target.normalized()
	
	var current_direction = enemy.velocity.normalized()
	if current_direction.length_squared() < 0.1:
		current_direction = dir_to_target
	var new_direction = current_direction.lerp(dir_to_target, turn_speed * delta)
	
	enemy.velocity = new_direction.normalized() * move_speed
	
	enemy.move_and_slide()
	
