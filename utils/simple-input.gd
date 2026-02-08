class_name SimpleInput

static func get_vector() -> Vector2:
	var input := Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x += -1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_up"):
		input.y += -1
	return input.normalized()
