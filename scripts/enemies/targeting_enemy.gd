extends CharacterBody2D
class_name TargetingEnemy

var target: Node2D;

func take_damage(amount: float, tick_count: int, time_between_ticks: float, source: String) -> void:
	$Health.take_damage_over_time(amount, tick_count, time_between_ticks, source)

func find_new_target():
	var targets = get_tree().get_nodes_in_group("players")
	
	var nearest_target = null
	var nearest_target_dist_sq = 0.0
	for t in targets:
		var distance_sq = global_position.distance_squared_to(t.global_position)
		if nearest_target == null or distance_sq < nearest_target_dist_sq:
			nearest_target = t
			nearest_target_dist_sq = distance_sq
	
	target = nearest_target
