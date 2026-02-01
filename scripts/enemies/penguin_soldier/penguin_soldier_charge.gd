extends State

@export var enemy: TargetingEnemy

@export var charge_audio_player: AudioStreamPlayer2D

@export var attack_speed: float = 500
@export var max_time: float = 2.0
@export var collision_damage: float = 10.0

var direction_snapshot: Vector2

var timer: float = 0.0
var entities_hit: Array[int]

# Initialize the state. E.g. change the animation.
func enter() -> void:
	timer = 0.0
	entities_hit = []
	if charge_audio_player:
		charge_audio_player.play()

func physics_update(delta: float):
	timer += delta
	if timer >= max_time:
		finished.emit("IdleState")
		return
	
	enemy.velocity = direction_snapshot * attack_speed
	enemy.move_and_slide()
	
	var number_of_collisions = enemy.get_slide_collision_count()
	for i in range(number_of_collisions):
		var collision = enemy.get_slide_collision(i)
		var collider_id = collision.get_collider_id()
		if collider_id not in entities_hit:
			entities_hit.append(collider_id)
			var collider = collision.get_collider()
			if collider.has_method("take_damage"):
				collider.take_damage(collision_damage, 1, 1.0, "penguin_charge")

func _on_wind_up_state_locked_on(pos: Vector2) -> void:
	direction_snapshot = enemy.global_position.direction_to(pos)
