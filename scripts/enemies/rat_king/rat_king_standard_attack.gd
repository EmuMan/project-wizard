extends State

@export var enemy: TargetingEnemy

@export var bullet_scene: PackedScene

@export var shoot_cooldown: float = 1.0
@export var state_duration: float = 20.0

var shoot_timer: float
var state_timer: float

func enter():
	shoot_timer = 0.0
	state_timer = 0.0

func physics_update(delta: float):
	shoot_timer += delta
	state_timer += delta
	
	if state_timer > state_duration:
		finished.emit("WindUpState")
		return
	
	if shoot_timer < shoot_cooldown:
		return
	
	enemy.find_new_target()
	
	if not enemy.target:
		return
	
	var shoot_point = enemy.find_child("ShootPoint").global_position
	var bullet = bullet_scene.instantiate()
	bullet.init_bullet(shoot_point, enemy.target.global_position)
	get_tree().current_scene.add_child(bullet)
	
	shoot_timer = 0.0
