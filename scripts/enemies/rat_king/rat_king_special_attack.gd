extends State

@export var enemy: CharacterBody2D

@export var bullet_scene: PackedScene

@export var min_target: Vector2 = Vector2(100, 300)
@export var max_target: Vector2 = Vector2(900, 600)

var has_shot: bool

func enter():
	has_shot = false

func physics_update(_delta: float):
	if has_shot:
		return
	
	var target_x = randf_range(min_target.x, max_target.x)
	var target_y = randf_range(min_target.y, max_target.y)
	var target_pos = Vector2(target_x, target_y)
	
	var bullet = bullet_scene.instantiate()
	bullet.target_position = target_pos
	bullet.global_position = enemy.global_position
	get_tree().current_scene.add_child(bullet)
	
	has_shot = true
	
	finished.emit("StandardAttackState")
