extends State

@export var enemy: CharacterBody2D
@export var target: Node2D

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
	
	if not target:
		return
	
	var dir_to_target = (target.global_position - enemy.global_position).normalized()
	var bullet = bullet_scene.instantiate()
	bullet.global_position = enemy.global_position
	bullet.direction = dir_to_target
	get_tree().current_scene.add_child(bullet)
	
	has_shot = true
	
	finished.emit("FollowState")
