extends Resource

class_name Inventory

signal update

@export var items: Array[ItemData]
@export var equipped: Array[ItemData]

func insert(item: ItemData):
	for i in range(items.size()):
		if items[i] == null:
			items[i] = item
			update.emit()
			return
