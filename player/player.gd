extends CharacterBody2D

@export var speed: float = 200
@export var acceleration: float = 1000
@export var friction: float = 2200

func _physics_process(delta: float) -> void:
	var input = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x += -1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_up"):
		input.y += -1

	input = input.normalized()
	
	if input == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		velocity = velocity.move_toward(input * speed, acceleration * delta)

	move_and_slide()
