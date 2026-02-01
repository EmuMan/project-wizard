extends State

@export var enemy: TargetingEnemy

@export var attack_speed: float = 500
@export var max_time: float = 2.0

var direction_snapshot: Vector2

var timer: float = 0.0

# Initialize the state. E.g. change the animation.
func enter() -> void:
	timer = 0.0

func physics_update(delta: float):
	timer += delta
	if timer >= max_time:
		finished.emit("IdleState")
		return
	
	enemy.velocity = direction_snapshot * attack_speed
	enemy.move_and_slide()

func _on_wind_up_state_locked_on(pos: Vector2) -> void:
	direction_snapshot = enemy.global_position.direction_to(pos)
