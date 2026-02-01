extends Node

signal took_damage(amount: float)
signal died

@export var flash_on_damage: FlashOnDamage

@export var max_health: float = 100.0

var health: float
var alive: bool

var special_damage_cooldowns: Dictionary[String, float] = {
	"poison_puddle": 0.5,
}

var special_damage_timers: Dictionary[String, float]

func _ready() -> void:
	health = max_health
	alive = true
	special_damage_timers = {}
	for damage_name in special_damage_cooldowns.keys():
		special_damage_timers[damage_name] = 0.0

func _physics_process(delta: float) -> void:
	for damage_name in special_damage_timers.keys():
		special_damage_timers[damage_name] += delta

func take_damage_once(amount: float, source: String) -> void:
	if not alive:
		return
	
	var cooldown = special_damage_cooldowns.get(source)
	var timer = special_damage_timers.get(source)
	if cooldown != null and timer != null:
		if timer < cooldown:
			return
		special_damage_timers[source] = 0.0
	
	health -= amount
	took_damage.emit(amount)
	
	if flash_on_damage:
		flash_on_damage.flash()
	
	if health <= 0:
		died.emit()
		alive = false
		health = 0

func take_damage_over_time(amount: float, tick_count: int, time_per_tick: float, source: String) -> void:
	for _i in range(tick_count):
		take_damage_once(amount, source)
		await get_tree().create_timer(time_per_tick).timeout
