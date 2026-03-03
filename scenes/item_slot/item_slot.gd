extends Control


var ItemScene: PackedScene = preload("res://scenes/item/item.tscn")


func add_item(item_data) -> void:
	if item_data == null:
		return
	
	var item = ItemScene.instantiate()
	item.add_icon(item_data)
	$ItemContainer/CenterContainer.add_child(item)
