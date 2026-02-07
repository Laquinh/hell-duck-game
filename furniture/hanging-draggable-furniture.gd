extends FurnitureBehavior

@export var dance_amplitude: float = 4
@export var dance_speed: float = 5

var dance_time: float = 0
var stuck_to_wall: bool = true
var time_under_stress: float = 0

func _ready() -> void:
	get_parent().freeze = true

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if stuck_to_wall:
		return
		
	if is_possessed:
		dance_time += delta * dance_speed
		get_parent().rotation_degrees = dance_amplitude * sin(dance_time)
	else:
		get_parent().rotation_degrees = 0
	
	get_parent().linear_velocity += Vector2(0, 200) * delta
	var current_velocity: Vector2 = get_parent().linear_velocity
	get_parent().linear_velocity -= current_velocity * delta * delta * 40
	
func possesed_movement(speed: float, acceleration: float, delta: float):
	var input := Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_pressed("move_left"):
		input.x += -1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_up"):
		input.y += -1
	
	if stuck_to_wall:
		if input != Vector2.ZERO:
			time_under_stress += delta
			dance_time += delta * dance_speed * time_under_stress * 4
			get_parent().rotation_degrees = dance_amplitude * sin(dance_time)
			if time_under_stress >= 2:
				stuck_to_wall = false
				get_parent().freeze = false
		else:
			get_parent().rotation_degrees = dance_amplitude * sin(dance_time)
			time_under_stress = 0
		return
	
	if input.length() > 0:
		input = input.normalized()
	input.y *= 3
	
	get_parent().linear_velocity += input * speed * delta * 2

func toggle_possessed() -> void:
	super.toggle_possessed()
