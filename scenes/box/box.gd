extends StaticBody2D


var player_near = false
@onready var sprite = $Sprite2D
@onready var area = $Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#area.body_entered.connect(_on_body_entered)
	#area.body_exited.connect(_on_body_exited)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


#func _on_body_entered(body) -> void:
	#if body.name == "Player" and player_near == false and body.interact_target == null:
		#player_near = true
		#body.interact_target = self
		#
		#var tween = create_tween()
		#tween.tween_property(sprite, "modulate", Color(1.5, 1.5, 1.5), 0.1)
#
#
#func _on_body_exited(body) -> void:
	#if body.name == "Player" and player_near == true and body.interact_target == self:
		#player_near = false
		#body.interact_target = null
		#
		#var tween = create_tween()
		#tween.tween_property(sprite, "modulate", Color(1, 1, 1), 0.1)
		#
		#interact("body_exited")
#
#
#func interact(state) -> void:
	#var ui = get_parent().get_node("CanvasLayer")
	#ui.box_ui(state)
