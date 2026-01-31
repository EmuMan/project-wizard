extends Node
class_name FlashOnDamage

@export var sprite: Sprite2D

@export var flash_color = Color.RED
@export var flash_duration = 0.1

var flash_timer: float

func _ready() -> void:
	flash_timer = 0

func _process(delta: float) -> void:
	if flash_timer > 0:
		flash_timer -= delta
		if flash_timer <= 0:
			flash_timer = 0
			sprite.modulate = Color.WHITE

func flash() -> void:
	sprite.modulate = flash_color
	flash_timer = flash_duration
