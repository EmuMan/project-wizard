extends State

signal locked_on(pos: Vector2)

@export var enemy: TargetingEnemy

@export var wobble_distance: float = 5
@export var wobble_time: float = 0.5

@export var next_state_name: String

var time_elapsed: float = 0
var start_position: Vector2

# Initialize the state. E.g. change the animation.
func enter() -> void:
	time_elapsed = 0
	start_position = enemy.position
	locked_on.emit(enemy.target.global_position)
	
func physics_update(delta: float):
	time_elapsed += delta
	if time_elapsed >= wobble_time:
		enemy.position = start_position
		finished.emit(next_state_name)
	else:
		var x_disp = randf_range(-wobble_distance, wobble_distance)
		var y_disp = randf_range(-wobble_distance, wobble_distance)
		var displacement = Vector2(x_disp, y_disp)
		enemy.position = start_position + displacement
