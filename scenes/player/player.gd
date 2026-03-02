extends CharacterBody2D


var max_speed := 60.0
var acceleration := 600.0
var friction := 300.0
var interact_target = null

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("walk_right") - Input.get_action_strength("walk_left"),
		Input.get_action_strength("walk_down") - Input.get_action_strength("walk_up")
	).normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	look_at(get_global_mouse_position())
	rotation += PI / 2
	
	move_and_slide()
	
	if Input.is_action_just_pressed("interact"):
		print("E")
