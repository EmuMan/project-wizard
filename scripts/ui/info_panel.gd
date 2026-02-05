extends Control

class_name InfoPanel

@onready var label: Label = $Label

func display(item: ItemData) -> void:
	label.text = item.display_name + ":\n"
	label.text += item.description
	visible = true
