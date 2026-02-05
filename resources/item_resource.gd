extends Resource
class_name ItemData

@export var display_name: String = ""
@export_multiline var description: String = ""
@export var texture: Texture2D # Icon for the UI
@export var quantity: int = 1 # For stackable items
@export var max_stack_size: int = 1
@export var action: UsageAction
