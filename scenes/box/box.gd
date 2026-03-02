extends StaticBody2D


var BoxUIScene = preload("res://scenes/box_ui/box_ui.tscn")
var rng = RandomNumberGenerator.new()
var ui_instance = null
var player_inside = false
@onready var area = $Area2D
@onready var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	
	rng.randomize()
	add_items_to_box()


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
	
	if ui_instance:
		close_ui()
	else:
		open_ui()
 

func open_ui() -> void:
	ui_instance = BoxUIScene.instantiate()
	get_tree().current_scene.get_node("UI").add_child(ui_instance)
	ui_instance.get_node("Label").text = str(get_instance_id())


func close_ui() -> void:
	if ui_instance:
		ui_instance.queue_free()
		ui_instance = null


func add_items_to_box() -> void:
	pass
