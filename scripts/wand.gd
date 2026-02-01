extends Node2D


var wand: ItemData
@onready var wand_sprite: Sprite2D = $WandSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if wand:
		wand_sprite.texture = wand.texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if wand and !wand_sprite.texture:
		wand_sprite.texture = wand.texture
	look_at(get_global_mouse_position())
