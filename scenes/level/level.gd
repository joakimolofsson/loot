extends Node2D


var BoxScene: PackedScene = preload("res://scenes/box/box.tscn")
@onready var spawn_tiles = $SpawnTiles
@onready var boxes = $Boxes


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cells = spawn_tiles.get_used_cells()
	cells.shuffle()
	
	var selected = cells.slice(0, 10)
	
	for cell in selected:
		var box = BoxScene.instantiate()
		boxes.add_child(box)
		box.global_position = spawn_tiles.map_to_local(cell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
