extends Node2D


const KILL_GOAL = 10

@onready var progress_bar: ProgressBar = $Camera2D/CanvasLayer/ProgressBar
var boss = preload("uid://b71glf4ej7dt6")
var kill_count = 0
var rat_king: CharacterBody2D
var boss_spawned = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !rat_king:
		rat_king = get_tree().get_first_node_in_group("RatBoss")
	if rat_king:
		progress_bar.value = rat_king.health.health
	if kill_count >= KILL_GOAL and not boss_spawned:
		print("spawned boss")
		var boss_node = boss.instantiate()
		get_tree().current_scene.add_child(boss_node)
		boss_spawned = true

func _on_enemy_spawn_enemy_death() -> void:
	kill_count += 1

func _on_enemy_spawn_2_enemy_death() -> void:
	kill_count += 1

func _on_enemy_spawn_3_enemy_death() -> void:
	kill_count += 1

func _on_enemy_spawn_4_enemy_death() -> void:
	kill_count += 1
