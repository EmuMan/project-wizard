extends Node

signal enemy_death(enemy: Node)

var current_level = 0
var level_count = 3

func increment_level() -> int:
	if current_level < level_count:
		current_level += 1
	return current_level

func finish_current_level(delay: float = 0.0) -> void:
	await get_tree().create_timer(delay).timeout
	SceneManager.change_scene("Inventory")
