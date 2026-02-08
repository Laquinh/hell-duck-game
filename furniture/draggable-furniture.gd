extends FurnitureBehavior
class_name DraggableFurniture

@export var dance_amplitude: float = 4
@export var dance_speed: float = 5

var dance_time: float = 0

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	_dance(delta)
	_gravity_and_resistance(delta)

func possesed_movement(speed: float, acceleration: float, delta: float) -> void:
	var input: Vector2 = _get_input_vector()
	_draggable_movement(input, speed, acceleration, delta)

func _dance(delta) -> void:
	if is_possessed:
		dance_time += delta * dance_speed
		get_parent().rotation_degrees = dance_amplitude * sin(dance_time)
	else:
		get_parent().rotation_degrees = 0

func _gravity_and_resistance(delta: float) -> void:
	get_parent().linear_velocity += Vector2(0, 200) * delta
	var current_velocity: Vector2 = get_parent().linear_velocity
	get_parent().linear_velocity -= current_velocity * delta * delta * 40

func _get_input_vector() -> Vector2:
	var input := Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x += -1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_up"):
		input.y += -1
	return input

func _draggable_movement(input: Vector2, speed: float, acceleration: float, delta: float) -> void:
	if input.length() > 0:
		input = input.normalized()
	if input.y < 0:
		input.y *= 3
	else:
		input.y *= 0.5
	get_parent().linear_velocity += input * speed * delta * 2

func toggle_possessed() -> void:
	super.toggle_possessed()
