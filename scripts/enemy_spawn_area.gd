extends Area2D

@export var spawn_cooldown: float = 20.0
@export var spawn_pool: Array[EnemySpawnData]
@export var spawn_instantly: bool = true

@onready var spawn_area: CollisionShape2D = $SpawnArea
@onready var spawn_timer: Timer = $SpawnTimer

signal spawn(enemies: Array[Node2D])

func _ready() -> void:
	spawn_timer.wait_time = spawn_cooldown
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start()
	if spawn_instantly:
		# if you spawn instantly it doesn't work fsr
		await get_tree().process_frame
		spawn_enemies()

func _on_spawn_timer_timeout() -> void:
	spawn_enemies()

func spawn_enemies():
	if len(spawn_pool) == 0:
		return
	
	if spawn_area.shape is CircleShape2D:
		var spawned = []
		var to_spawn = _pick_weighted_spawn()
		for i in range(to_spawn.count):
			var enemy = to_spawn.enemy_scene.instantiate()
			enemy.global_position = _get_random_point_in_circle(spawn_area.global_position, spawn_area.shape.radius)
			get_tree().current_scene.add_child(enemy)
			spawned.append(enemy)
		spawn.emit(spawned)
	else:
		push_warning("Unsupported spawn shape type")

func _pick_weighted_spawn() -> EnemySpawnData:
	var total_weight = 0.0
	for spawn_info in spawn_pool:
		total_weight += spawn_info.weight
	
	var random_value = randf() * total_weight
	var cumulative = 0.0
	
	for spawn_info in spawn_pool:
		cumulative += spawn_info.weight
		if random_value <= cumulative:
			return spawn_info
	
	return spawn_pool[0]

func _get_random_point_in_circle(center: Vector2, radius: float):
	return center + Vector2.from_angle(randf() * TAU) * randf() * radius
