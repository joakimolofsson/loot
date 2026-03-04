extends StaticBody2D


var BoxUIScene = preload("res://scenes/box_ui/box_ui.tscn")
var PlayerUIScene = preload("res://scenes/player_ui/player_ui.tscn")
var item_sheet = preload("res://assets/items_sheet.png")
var rng = RandomNumberGenerator.new()
var box_ui_instance = null
var player_ui_instance = null
var player_inside = false
var items_in_box = []
var box_opened = false
@onready var area = $Area2D
@onready var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.interactable_object = self
		player_inside = true
		
		var tween = create_tween()
		tween.tween_property($Sprite2D, "modulate", Color(1.5, 1.5, 1.5), 0.1)


func _on_body_exited(body) -> void:
	if body.is_in_group("player"):
		body.interactable_object = null
		player_inside = false
		
		var tween = create_tween()
		tween.tween_property($Sprite2D, "modulate", Color(1, 1, 1), 0.1)
		
		close_ui()


func interact() -> void:
	if not player_inside:
		return
	
	if box_ui_instance:
		close_ui()
	else:
		open_ui()
		box_opened = true
 

func open_ui() -> void:
	box_ui_instance = BoxUIScene.instantiate()
	player_ui_instance = PlayerUIScene.instantiate()
	
	var ui_tree = get_tree().current_scene.get_node("UI")
	ui_tree.add_child(player_ui_instance)
	ui_tree.add_child(box_ui_instance)
	
	
	box_ui_instance.build(self, items_in_box, box_opened)
	var player = get_tree().get_first_node_in_group("player")
	player_ui_instance.build(player)


func close_ui() -> void:
	if box_ui_instance:
		box_ui_instance.queue_free()
		box_ui_instance = null
		player_ui_instance.queue_free()
		player_ui_instance = null


func generate_items_to_box() -> void:
	var items = [
		{"name": "Shield", "icon": get_icon(0, 0)},
		{"name": "Sword", "icon": get_icon(0, 1)},
		{"name": "Club", "icon": get_icon(0, 2)},
		{"name": "Bow", "icon": get_icon(1, 0)},
		{"name": "Arrow", "icon": get_icon(1, 1)},
		{"name": "Staff", "icon": get_icon(1, 2)},
		{"name": "Silver", "icon": get_icon(2, 0)},
		{"name": "Health Potion", "icon": get_icon(2, 1)},
		{"name": "Mana Potion", "icon": get_icon(2, 2)}
	]
	
	for i in rng.randi_range(2, 5):
		items_in_box.append(items.pick_random())
	
	# Kopia av array, shuffle items, tar dom 3 första, inga duplicates
	#var items_copy = items.duplicate()
	#items_copy.shuffle()
	#var picked_items = items_copy.slice(0, 3)


func get_icon(col, row):
	var icon = AtlasTexture.new()
	icon.atlas = item_sheet
	icon.region = Rect2(col * 8, row * 8, 8, 8)
	return icon


func add_item(item):
	items_in_box.append(item)

func remove_item(item):
	items_in_box.erase(item)
