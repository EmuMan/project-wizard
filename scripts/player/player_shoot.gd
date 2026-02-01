extends Node2D

@export var bullet_scene: PackedScene
# TODO: different cooldowns for different staffs
@export var cooldown: float = 0.5

var time_since_last_shot: float

func _physics_process(delta: float) -> void:
	time_since_last_shot += delta
	
	if time_since_last_shot >= cooldown and Input.is_action_pressed("attack"):
		shoot(get_global_mouse_position())
		time_since_last_shot = 0.0

func shoot(click_pos: Vector2) -> void:
	if not bullet_scene:
		return
	
	var bullet = bullet_scene.instantiate()
	bullet.init_bullet(global_position, click_pos)
	get_tree().current_scene.add_child(bullet)
