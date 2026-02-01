extends State

@export var enemy: TargetingEnemy

@export var bullet_scene: PackedScene

@export var warmup_time: float = 3.0

var timer: float = 0.0
var has_shot: bool

func enter():
	timer = 0.0
	has_shot = false

func physics_update(delta: float):
	timer += delta
	if timer < warmup_time or has_shot:
		return
	
	if not enemy.target:
		return
	
	var dir_to_target = enemy.global_position.direction_to(enemy.target.global_position)
	var bullet = bullet_scene.instantiate()
	bullet.global_position = enemy.global_position
	bullet.direction = dir_to_target
	get_tree().current_scene.add_child(bullet)
	
	has_shot = true
	
	finished.emit("FollowState")
