extends State

@export var enemy: CharacterBody2D

@export var bullet_scene: PackedScene

@export var min_target: Vector2 = Vector2(-500, -300)
@export var max_target: Vector2 = Vector2(500, 300)

var has_shot: bool

func enter():
	has_shot = false

func physics_update(_delta: float):
	if has_shot:
		return
	
	var target_x = randf_range(min_target.x, max_target.x)
	var target_y = randf_range(min_target.y, max_target.y)
	var target_pos = Vector2(target_x, target_y)
	
	var shoot_point = enemy.find_child("ShootPoint").global_position
	var bullet = bullet_scene.instantiate()
	bullet.init_bullet(shoot_point, target_pos)
	get_tree().current_scene.add_child(bullet)
	
	has_shot = true
	
	finished.emit("StandardAttackState")
