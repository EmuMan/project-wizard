extends State

@export var enemy: CharacterBody2D
@export var target: Node2D

@export var target_radius: float = 1_000.0


func physics_update(_delta: float):
	if not target:
		return
	
	var disp_to_target = target.global_position - enemy.global_position
	if disp_to_target.length_squared() <= target_radius ** 2:
		finished.emit("FollowState")
