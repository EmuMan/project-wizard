extends State

@export var enemy: TargetingEnemy

@export var wobble_distance: float = 5.0
@export var wobble_time: float = 3.0

var time_elapsed: float = 0
var start_position: Vector2

func enter() -> void:
	time_elapsed = 0
	start_position = enemy.position
	
func physics_update(delta: float):
	time_elapsed += delta
	if time_elapsed >= wobble_time:
		enemy.position = start_position
		finished.emit("SpecialAttackState")
	else:
		var x_disp = randf_range(-wobble_distance, wobble_distance)
		var y_disp = randf_range(-wobble_distance, wobble_distance)
		var displacement = Vector2(x_disp, y_disp)
		enemy.position = start_position + displacement
