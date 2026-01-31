extends CharacterBody2D

func take_damage(amount: float, tick_count: int, time_between_ticks: float) -> void:
	$Health.take_damage_over_time(amount, tick_count, time_between_ticks)
