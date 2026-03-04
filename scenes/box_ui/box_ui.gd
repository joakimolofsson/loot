extends Control


var ItemSlotScene: PackedScene = preload("res://scenes/item_slot/item_slot.tscn")


func _ready() -> void:
	pass


func build(box_items, box_opened) -> void:
	for i in range(6):
		var item_slot = ItemSlotScene.instantiate()
		$MarginContainer/GridContainer.add_child(item_slot)
		
		if i < box_items.size():
			item_slot.add_item(box_items[i])
			
			if not box_opened:
				var item_in_slot = item_slot.get_node("ItemContainer/CenterContainer").get_child(0)
				item_in_slot.modulate = Color(0.0, 0.0, 0.0, 1.0)
				reveal_item_animation(item_in_slot, i)


func reveal_item_animation(item: Control, index: int) -> void:
	var pause_before_reveal := 1
	await get_tree().create_timer(index * pause_before_reveal).timeout
	
	var tween = create_tween()
	var animation_time := 0.2
	tween.tween_property(item, "modulate", Color(1, 1, 1, 1), animation_time)
