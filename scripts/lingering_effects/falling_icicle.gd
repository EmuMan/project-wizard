extends Area2D

@onready var warning_hitbox: CollisionShape2D = $WarningHitbox
@onready var warning_sprite: Sprite2D = $WarningSprite
@onready var icicle_sprite: Sprite2D = $IcicleSprite
@onready var fallen_icicle: StaticBody2D = $IcicleSprite/FallenIcicle

@export var start_height: float = 1_000.0
@export var fall_speed: float = 300.0
@export var hit_damage: float = 30.0
@export var min_lifetime: float = 5.0
@export var max_lifetime: float = 10.0

var current_height: float
var fallen: bool = false
var lifetime: float
var timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_height = -start_height
	icicle_sprite.position.y = current_height
	lifetime = randf_range(min_lifetime, max_lifetime)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:	
	if fallen:
		timer += delta
		if timer >= lifetime:
			queue_free()
		return
	
	current_height = move_toward(current_height, 0, delta * fall_speed)
	icicle_sprite.position.y = current_height
	if current_height == 0.0:
		land()

func land() -> void:
	fallen = true
	for body in get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(hit_damage, 1, 1.0, "icicle_landing")
	fallen_icicle.set_deferred("process_mode", "inherit")
	warning_hitbox.set_deferred("process_mode", "disabled")
	warning_sprite.visible = false
