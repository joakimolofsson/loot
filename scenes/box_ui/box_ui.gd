extends Control


var ItemSlotScene: PackedScene = preload("res://scenes/item_slot/item_slot.tscn")
var current_box
var current_items = []
var current_box_opened = false


func _ready() -> void:
	add_to_group("inventory_ui")


func build(box, box_items, box_opened) -> void:
	current_box = box
	current_items = box_items
	current_box_opened = box_opened
	
	for i in range(6):
		var item_slot = ItemSlotScene.instantiate()
		$MarginContainer/GridContainer.add_child(item_slot)
		
		item_slot.owner_inventory = box
		item_slot.item_moved.connect(_on_item_moved)
		
		if i < box_items.size():
			var item_in_slot = item_slot.add_item(box_items[i])
			
			if not box_opened:
				item_in_slot.modulate = Color.BLACK
				reveal_item_animation(item_in_slot, i)


func reveal_item_animation(item: Control, index: int) -> void:
	var pause_before_reveal := 0.5
	await get_tree().create_timer(index * pause_before_reveal).timeout
	
	var tween = create_tween()
	var animation_time := 0.2
	tween.tween_property(item, "modulate", Color.WHITE, animation_time)
	tween.tween_property(item, "scale", Vector2(1.2, 1.2), 0.1)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
	
	tween.tween_property(item, "scale", Vector2.ONE, 0.1)


func _on_item_moved():
	rebuild_ui()


func rebuild_ui():
	for child in $MarginContainer/GridContainer.get_children():
		child.queue_free()

	build(current_box, current_box.items_in_box, true)
