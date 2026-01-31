extends Node

signal took_damage(amount: float)
signal died

@export var flash_on_damage: FlashOnDamage

@export var max_health: float = 100.0

var health: float
var alive: bool

func _ready() -> void:
	health = max_health
	alive = true

func take_damage_once(amount: float) -> void:
	if not alive:
		return
	
	health -= amount
	took_damage.emit(amount)
	
	if flash_on_damage:
		flash_on_damage.flash()
	
	if health <= 0:
		died.emit()
		alive = false
		health = 0

func take_damage_over_time(amount: float, tick_count: int, time_per_tick: float) -> void:
	for _i in range(tick_count):
		take_damage_once(amount)
		await get_tree().create_timer(time_per_tick).timeout
