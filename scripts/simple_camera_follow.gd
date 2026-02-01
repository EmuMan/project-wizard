extends Camera2D

@export var target: Node2D
@export var move_speed: float = 5.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not target:
		return
	
	offset = lerp(offset, target.global_position, delta * move_speed)
