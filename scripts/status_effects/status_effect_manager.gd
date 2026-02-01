extends Node
class_name StatusEffectManager

var active_effects: Array[StatusEffect] = []

func _physics_process(delta: float) -> void:
	# iterate backwards so we don't fuck up the iteration
	for i in range(len(active_effects) - 1, -1, -1):
		active_effects[i].duration -= delta
		if active_effects[i].duration <= 0:
			active_effects.remove_at(i)

func add_effect(effect: StatusEffect) -> void:
	active_effects.append(effect)

func remove_effects_by_source(source_id: String) -> void:
	for i in range(len(active_effects) - 1, -1, -1):
		if active_effects[i].source_id == source_id:
			active_effects.remove_at(i)

func get_cumulative_strength(effect_type: String, multiplicative: bool = false) -> float:
	var cum = 1.0 if multiplicative else 0.0
	for effect in active_effects:
		if effect.effect_type == effect_type:
			if multiplicative:
				cum *= effect.strength
			else:
				cum += effect.strength
	return cum

func get_max_strength(effect_type: String) -> float:
	var max_strength = 0.0
	for effect in active_effects:
		if effect.effect_type == effect_type and effect.strength > max_strength:
			max_strength = effect.strength
	return max_strength
