extends Area2D

@export var speed: float = 200
@export var target_position: Vector2

@export var damage_amount: float = 10.0
@export var damage_tick_count: int = 5
@export var damage_time_between_ticks: float = 1.0

@export var explosion_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_collide)
	area_entered.connect(_on_collide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var new_position = position.move_toward(target_position, speed * delta)
	if new_position == target_position:
		explode()
	else:
		position = new_position

func _on_collide(other: Node2D):
	if other.has_method("take_damage"):
		other.take_damage(damage_amount, damage_tick_count, damage_time_between_ticks, "bullet")
	explode()

func explode():
	if explosion_scene:
		var explosion = explosion_scene.instantiate()
		explosion.global_position = global_position
		get_tree().current_scene.add_child(explosion)
	queue_free()
