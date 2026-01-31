extends State

@export var enemy: CharacterBody2D

@export var move_frequency: float = 0.5
@export var move_distance: float = 200
@export var wobble_frequency: float = 1.25
@export var wobble_distance: float = 40

var time_elapsed: float = 0
var start_position: Vector2

func ready() -> void:
	start_position = enemy.position

# Initialize the state. E.g. change the animation.
func enter() -> void:
	print("Entering move state...")
	time_elapsed = 0

# Clean up the state. Reinitialize values like a timer.
func exit() -> void:
	print("Exiting move state...")

func physics_update(delta: float):
	var x_displacement = sin(time_elapsed * 2 * PI * move_frequency) * move_distance
	var y_displacement = sin(time_elapsed * 2 * PI * wobble_frequency) * wobble_distance
	
	enemy.position = start_position + Vector2(x_displacement, y_displacement)
	
	time_elapsed += delta
	
	if time_elapsed >= 10:
		finished.emit("WindUpState")
	
