extends CharacterBody2D


var max_speed := 50.0
var acceleration := 600.0
var friction := 300.0
var interactable_object = null
var items_in_backpack = []
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left"),
		Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	).normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	var is_moving = velocity.length() > 1
	if is_moving:
		if animated_sprite.animation != "walk":
			animated_sprite.play("walk")
	else:
		if animated_sprite.animation != "default":
			animated_sprite.play("default")
	
	look_at(get_global_mouse_position())
	rotation += PI / 2
	
	move_and_slide()


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and interactable_object:
		interactable_object.interact()


func add_item(item):
	items_in_backpack.append(item)

func remove_item(item):
	items_in_backpack.erase(item)
