extends StaticBody2D


@export var item: ItemData

var player = null

func _on_collect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Pickup"):
		player = get_tree().get_first_node_in_group("Player")
		player.collect(item)
		await get_tree().create_timer(0.5).timeout
		self.queue_free()
		for n in get_tree().current_scene.get_children():
			if n.is_in_group("Enemy"):
				n.queue_free()
		SceneManager.change_scene("Inventory")
