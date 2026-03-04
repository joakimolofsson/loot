extends Node2D


var BoxScene: PackedScene = preload("res://scenes/box/box.tscn")
@onready var spawn_tiles = $SpawnTiles
@onready var boxes = $Boxes


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var all_the_spawn_tiles = spawn_tiles.get_used_cells()
	all_the_spawn_tiles.shuffle()
	
	var amount_of_boxes := 12
	var spawn_positions = all_the_spawn_tiles.slice(0, amount_of_boxes)
	
	for i in spawn_positions.size():
		var box = BoxScene.instantiate()
		boxes.add_child(box)
		box.global_position = spawn_tiles.map_to_local(spawn_positions[i])
		
		var boxes_that_should_have_items = int(amount_of_boxes / 2.0)
		if i < boxes_that_should_have_items:
			box.generate_items_to_box()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
