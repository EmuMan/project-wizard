extends Area2D

@export var speed: float = 500
@export var direction: Vector2
@export var damage_amount: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_collide)
	area_entered.connect(_on_collide)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)

func _on_collide(other: Node2D):
	if other.has_method("take_damage"):
		other.take_damage(damage_amount)
	queue_free()
