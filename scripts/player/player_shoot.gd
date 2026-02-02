extends Node2D


@onready var inventory: Inventory = preload("res://Inventory/PlayerInventory.tres")
@export var bullet_scene: PackedScene
@export var rat_special_scene: PackedScene
@export var penguin_special_scene: PackedScene
# TODO: different cooldowns for different staffs
@export var shoot_cooldown: float = 0.5
@export var ability_cooldown: float = 10.0

var time_since_last_shot: float
var time_since_last_ability: float

func _physics_process(delta: float) -> void:
	time_since_last_shot += delta
	time_since_last_ability += delta
	
	if time_since_last_shot >= shoot_cooldown and Input.is_action_pressed("attack"):
		shoot(get_global_mouse_position())
	if time_since_last_ability >= ability_cooldown and Input.is_action_pressed("special"):
		special(get_global_mouse_position())

func shoot(click_pos: Vector2) -> void:
	if not bullet_scene:
		return
	
	var bullet = bullet_scene.instantiate()
	bullet.init_bullet(global_position, click_pos)
	get_tree().current_scene.add_child(bullet)
	
	time_since_last_shot = 0.0
	
func special(click_pos: Vector2):
	if inventory.equipped[0]:
		if inventory.equipped[0].display_name == "Rat Mask":
			if not rat_special_scene:
				return
			var bullet = rat_special_scene.instantiate()
			bullet.init_bullet(global_position, click_pos)
			get_tree().current_scene.add_child(bullet)
		elif inventory.equipped[0].display_name == "Emperor Mask":
			if not penguin_special_scene:
				return
			var bullet = penguin_special_scene.instantiate()
			bullet.init_bullet(global_position, click_pos)
			get_tree().current_scene.add_child(bullet)
		
		time_since_last_ability = 0.0
