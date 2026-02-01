extends State

signal locked_on(pos: Vector2)

@export var enemy: Area2D
@export var target: Node2D

@export var wobble_distance: float = 5

var time_elapsed: float = 0
var start_position: Vector2

# Initialize the state. E.g. change the animation.
func enter() -> void:
	print("Entering wind up state...")
	time_elapsed = 0
	start_position = enemy.position
	locked_on.emit(target.position)

# Clean up the state. Reinitialize values like a timer.
func exit() -> void:
	print("Exiting wind up state...")
	
func physics_update(delta: float):
	time_elapsed += delta
	if time_elapsed >= 1:
		enemy.position = start_position
		finished.emit("AttackState")
	else:
		var x_disp = randf_range(-wobble_distance, wobble_distance)
		var y_disp = randf_range(-wobble_distance, wobble_distance)
		var displacement = Vector2(x_disp, y_disp)
		enemy.position = start_position + displacement
