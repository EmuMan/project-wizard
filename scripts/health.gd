extends Node2D
class_name Health

signal took_damage(amount: float)
signal death

@export var flash_on_damage: FlashOnDamage

@export var max_health: float = 100.0

@export var remove_on_death: Node
@export var death_scene: PackedScene

var current_health: float
var alive: bool

var special_damage_cooldowns: Dictionary[String, float] = {
	"poison_puddle": 0.5,
}

var special_damage_timers: Dictionary[String, float]

func _ready() -> void:
	current_health = max_health
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
	
	current_health -= amount
	took_damage.emit(amount)
	
	if flash_on_damage:
		flash_on_damage.flash()
	
	if current_health <= 0:
		die()

func take_damage_over_time(amount: float, tick_count: int, time_per_tick: float, source: String) -> void:
	for _i in range(tick_count):
		take_damage_once(amount, source)
		await get_tree().create_timer(time_per_tick).timeout

func die():
	death.emit()
	alive = false
	current_health = 0
	
	if death_scene:
		var death_inst = death_scene.instantiate()
		death_inst.global_position = global_position
		get_tree().current_scene.add_child(death_inst)
	
	if remove_on_death:
		remove_on_death.queue_free()

func get_percentage() -> float:
	return 100.0 * float(current_health) / float(max_health)
