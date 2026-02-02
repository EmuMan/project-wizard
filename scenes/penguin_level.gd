extends Node2D


const KILL_GOAL = 2

@onready var progress_bar: ProgressBar = $Camera2D/CanvasLayer/ProgressBar
var boss = preload("res://prefabs/enemies/emperor_penguin.tscn")
var kill_count = 0
var emperor: CharacterBody2D
var boss_spawned = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !emperor:
		emperor = get_tree().get_first_node_in_group("PengBoss")
	if emperor:
		progress_bar.value = emperor.health.health
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
