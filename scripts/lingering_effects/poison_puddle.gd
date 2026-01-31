extends Area2D

@export var damage_amount: float = 1.0

func _physics_process(_delta: float) -> void:
	for area in get_overlapping_areas():
		_on_collide(area)
	for body in get_overlapping_bodies():
		_on_collide(body)

func _on_collide(other: Node2D):
	if other.has_method("take_damage"):
		other.take_damage(damage_amount, 1, 1.0, "poison_puddle")
