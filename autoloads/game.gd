extends Node

signal enemy_death(enemy: Node)

var current_level = 0
var level_count = 3

func increment_level() -> int:
	if current_level < level_count:
		current_level += 1
	return current_level
