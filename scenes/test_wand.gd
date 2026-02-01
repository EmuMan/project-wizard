extends StaticBody2D


@export var item: ItemData

var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_collect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pickup"):
		player = get_tree().get_first_node_in_group("Player")
		player.collect(item)
		await get_tree().create_timer(0.5).timeout
		self.queue_free()
