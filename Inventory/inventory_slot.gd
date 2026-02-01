extends Panel


class_name InventorySlot

@onready var item_display: Sprite2D = $CenterContainer/Panel/ItemDisplay

signal hovering_started
signal hovering_ended
signal clicked(slot)

func update(item: ItemData):
	if !item:
		item_display.visible = false
	else:
		item_display.texture = item.texture
		item_display.visible = true

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		clicked.emit(self)

func _on_mouse_entered() -> void:
	hovering_started.emit(self)

func _on_mouse_exited() -> void:
	hovering_ended.emit()
