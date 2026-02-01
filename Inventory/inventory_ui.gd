extends Control


@onready var inventory: Inventory = preload("res://Inventory/PlayerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var info_panel: InfoPanel = $NinePatchRect/InfoPanel
@onready var player: CharacterBody2D = $NinePatchRect/HBoxContainer/PlayerContainer/Container/Player
@onready var held_item_sprite: Sprite2D = $HeldItem
@onready var mask_slot: InventorySlot = $NinePatchRect/HBoxContainer/MaskContiner/MaskSlot
@onready var wand_slot: InventorySlot = $NinePatchRect/HBoxContainer/WandContainer/WandSlot

var held_item: ItemData
var held_index = -1

func update_slots():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])
	mask_slot.update(inventory.equipped[0])
	wand_slot.update(inventory.equipped[1])

func hovering_started(slot: InventorySlot):
	if !inventory.items[slots.find(slot)]:
		return
	info_panel.display(inventory.items[slots.find(slot)])

func hovering_ended():
	info_panel.visible = false

func connect_slots():
	for i in range(slots.size()):
		var slot: InventorySlot = slots[i]
		slot.hovering_started.connect(hovering_started)
		slot.hovering_ended.connect(hovering_ended)
		slot.clicked.connect(on_slot_clicked)
	mask_slot.hovering_started.connect(hovering_started)
	mask_slot.hovering_ended.connect(hovering_ended)
	mask_slot.clicked.connect(on_slot_clicked)
	wand_slot.hovering_started.connect(hovering_started)
	wand_slot.hovering_ended.connect(hovering_ended)
	wand_slot.clicked.connect(on_slot_clicked)

func on_slot_clicked(slot: InventorySlot):
	if slot == mask_slot:
		# If holding nothing → pick up
		if held_item == null:
			var item := inventory.equipped[0]
			if item == null:
				return

			held_item = item
			inventory.equipped[0] = null

			held_item_sprite.texture = item.texture
			held_item_sprite.visible = true
			update_slots()
			return

		# If holding something → drop
		var target_item := inventory.equipped[0]

		# Swap
		inventory.equipped[0] = held_item
		inventory.items[held_index] = target_item

		held_item = null
		held_index = -1
		held_item_sprite.visible = false
	elif slot == wand_slot:
		# If holding nothing → pick up
		if held_item == null:
			var item := inventory.equipped[1]
			if item == null:
				return

			held_item = item
			inventory.equipped[1] = null

			held_item_sprite.texture = item.texture
			held_item_sprite.visible = true
			update_slots()
			return

		# If holding something → drop
		var target_item := inventory.equipped[1]

		# Swap
		inventory.equipped[1] = held_item
		inventory.items[held_index] = target_item

		held_item = null
		held_index = -1
		held_item_sprite.visible = false
	else:
		var index := slots.find(slot)

		# If holding nothing → pick up
		if held_item == null:
			var item := inventory.items[index]
			if item == null:
				return

			held_item = item
			held_index = index
			inventory.items[index] = null

			held_item_sprite.texture = item.texture
			held_item_sprite.visible = true
			update_slots()
			return

		# If holding something → drop
		var target_item := inventory.items[index]

		# Swap
		inventory.items[index] = held_item
		inventory.items[held_index] = target_item

		held_item = null
		held_index = -1
		held_item_sprite.visible = false

	update_slots()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.can_move = false
	inventory.update.connect(update_slots)
	update_slots()
	connect_slots()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if held_item:
		held_item_sprite.global_position = get_global_mouse_position()

func _on_prev_level_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		SceneManager.change_scene("TestLevel"+str(Game.level))

func _on_next_level_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and Game.level < SceneManager.SCENES.size()-1:
		Game.level += 1
		SceneManager.change_scene("TestLevel"+str(Game.level))
