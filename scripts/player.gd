extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var mask: ItemData
@export var wand: ItemData
var can_move = true
@export var inventory: Inventory
@onready var mask_sprite: Sprite2D = $MaskSprite
@onready var wand_node: Node2D = $Wand
@onready var health: Health = $Health
@onready var status_effects: StatusEffectManager = $StatusEffectManager

func _ready():
	mask = inventory.equipped[0]
	wand = inventory.equipped[1]
	if mask:
		mask_sprite.texture = mask.texture
	if wand:
		wand_node.wand = wand

func _physics_process(_delta: float) -> void:
	if can_move:
		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_vector("left", "right", "up", "down").normalized()
		if direction.length() > 0:
			var speed_multiplier = 1.0 - status_effects.get_max_strength("slow")
			velocity = direction * SPEED * speed_multiplier
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)

		move_and_slide()

func _process(_delta: float) -> void:
	if mask and !mask_sprite.texture:
		mask_sprite.texture = mask.texture
	if wand and !wand_node.wand:
		wand_node.wand = wand

func take_damage(amount: float, tick_count: int, time_between_ticks: float, source: String) -> void:
	health.take_damage_over_time(amount, tick_count, time_between_ticks, source)

func apply_status_effect(effect: StatusEffect) -> void:
	status_effects.add_effect(effect)

func collect(item: ItemData):
	inventory.insert(item)
