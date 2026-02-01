extends Area2D


var rat_node = preload("res://prefabs/enemies/rat.tscn")
var rz_node = preload("res://prefabs/enemies/rat_zombie.tscn")
@onready var shape: CollisionShape2D = $CollisionShape2D

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	var enemy = rat_node.instantiate()
	enemy.position = Vector2(
		randf_range(-300+shape.global_position.x, 300+shape.global_position.x),
		randf_range(-300+shape.global_position.y, 300+shape.global_position.y)
	)
	get_tree().current_scene.add_child(enemy)
	enemy = rz_node.instantiate()
	enemy.position = Vector2(
		randf_range(-300+shape.global_position.x, 300+shape.global_position.x),
		randf_range(-300+shape.global_position.y, 300+shape.global_position.y)
	)
	get_tree().current_scene.add_child(enemy)
