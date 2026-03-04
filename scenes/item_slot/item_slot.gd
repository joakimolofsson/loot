extends Control


signal item_moved
var ItemScene: PackedScene = preload("res://scenes/item/item.tscn")
var slot_data = null
var owner_inventory = null


func _get_drag_data(_at_position):
	if slot_data == null:
		return null

	var preview = duplicate()
	set_drag_preview(preview)

	return {
		"item": slot_data,
		"from": owner_inventory
	}


func _can_drop_data(_at_position, data):
	return data is Dictionary and data.has("item")


func _drop_data(_at_position, data):
	var item = data["item"]
	var from_inventory = data["from"]

	owner_inventory.add_item(item)
	from_inventory.remove_item(item)

	item_moved.emit()
	get_tree().call_group("inventory_ui", "rebuild_ui")
	

func add_item(item_data):
	if item_data == null:
		return
	
	slot_data = item_data   # ← REQUIRED
	
	var item = ItemScene.instantiate()
	item.add_icon(item_data)
	$ItemContainer/CenterContainer.add_child(item)
	return item
