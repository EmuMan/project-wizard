extends Node2D


@onready var inventory: Inventory = preload("uid://bj2l5cejwy851")
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
	
	if inventory.equipped[1] and inventory.equipped[1].action:
		# TODO: shoot start charged should also work
		shoot_cooldown = inventory.equipped[1].action.cooldown_duration
	if time_since_last_shot >= shoot_cooldown and Input.is_action_pressed("attack"):
		shoot(get_global_mouse_position())
	
	if inventory.equipped[0] and inventory.equipped[0].action:
		# TODO: ability start charged should also work
		ability_cooldown = inventory.equipped[0].action.cooldown_duration
	if time_since_last_ability >= ability_cooldown and Input.is_action_pressed("special"):
		special(get_global_mouse_position())

func shoot(click_pos: Vector2) -> void:
	if inventory.equipped[1] and inventory.equipped[1].action and get_tree().current_scene is Node2D:
		inventory.equipped[1].action.use(self, click_pos, get_tree().current_scene)
		time_since_last_shot = 0.0
	
func special(click_pos: Vector2):
	if inventory.equipped[0] and inventory.equipped[0].action and get_tree().current_scene is Node2D:
		inventory.equipped[0].action.use(self, click_pos, get_tree().current_scene)
		time_since_last_ability = 0.0
