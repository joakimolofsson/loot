extends Control


var ItemSlotScene: PackedScene = preload("res://scenes/item_slot/item_slot.tscn")
var current_player


func _ready() -> void:
	add_to_group("inventory_ui")


func build(player) -> void:
	current_player = player

	for i in range(24):
		var item_slot = ItemSlotScene.instantiate()
		$MarginContainer/GridContainer.add_child(item_slot)

		item_slot.owner_inventory = player
		item_slot.item_moved.connect(_on_item_moved)

		if i < player.items_in_backpack.size():
			item_slot.add_item(player.items_in_backpack[i])


func rebuild_ui():
	for child in $MarginContainer/GridContainer.get_children():
		child.queue_free()

	build(current_player)


func _on_item_moved():
	rebuild_ui()
