extends Resource
class_name StatusEffect

var effect_type: String
var strength: float
var duration: float
var source_id: String

func _init(p_type: String, p_strength: float, p_duration: float, p_source: String = "") -> void:
	effect_type = p_type
	strength = p_strength
	duration = p_duration
	source_id = p_source if p_source else str(randi())
