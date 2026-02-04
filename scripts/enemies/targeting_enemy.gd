extends CharacterBody2D
class_name TargetingEnemy

@export var flip_to_face_target: bool = true
@export var flip_speed: float = 10.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var health: Health = $Health

var target: Node2D

var original_x_scale: float = 1.0
var current_flip_value: float = 1.0
var target_flip_value: float = 1.0

func _ready() -> void:
	original_x_scale = sprite.scale.x
	health.death.connect(_on_health_death)

func _process(delta: float) -> void:
	progress_flip(delta * flip_speed)

func _physics_process(_delta: float) -> void:
	calculate_flip()

func take_damage(amount: float, tick_count: int, time_between_ticks: float, source: String) -> void:
	health.take_damage_over_time(amount, tick_count, time_between_ticks, source)

func find_new_target():
	var targets = get_tree().get_nodes_in_group("Player")
	
	var nearest_target = null
	var nearest_target_dist_sq = 0.0
	for t in targets:
		var distance_sq = global_position.distance_squared_to(t.global_position)
		if nearest_target == null or distance_sq < nearest_target_dist_sq:
			nearest_target = t
			nearest_target_dist_sq = distance_sq
	
	target = nearest_target

func calculate_flip():
	if target:
		var new_flip = sign(global_position.x - target.global_position.x)
		if new_flip != 0:
			target_flip_value = new_flip

func progress_flip(delta: float):
	current_flip_value = move_toward(current_flip_value, target_flip_value, delta)
	sprite.scale.x = original_x_scale * current_flip_value

func _on_health_death() -> void:
	Game.enemy_death.emit()
