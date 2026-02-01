extends State

@export var enemy: Area2D

@export var attack_speed: float = 2_000

var target_pos_snapshot: Vector2
var start_pos_snapshot: Vector2

var first_phase: bool

# Initialize the state. E.g. change the animation.
func enter() -> void:
	print("Entering attack state...")
	start_pos_snapshot = enemy.position
	first_phase = true

# Clean up the state. Reinitialize values like a timer.
func exit() -> void:
	print("Exiting attack state...")
	
func physics_update(delta: float):
	if first_phase:
		enemy.position = enemy.position.move_toward(target_pos_snapshot, attack_speed * delta)
		if enemy.position == target_pos_snapshot:
			first_phase = false
	else:
		enemy.position = enemy.position.move_toward(start_pos_snapshot, attack_speed * delta)
		if enemy.position == start_pos_snapshot:
			finished.emit("MoveState")

func _on_wind_up_state_locked_on(pos: Vector2) -> void:
	target_pos_snapshot = pos
