extends FurnitureBehavior
class_name DraggableFurniture


@export var dance_amplitude: float = 4
@export var dance_speed: float = 5
@export var gravity_strength: float = 200
@export var resistance: float = 20
@export var speed_mult: float = 2 # to compensate for resestance and make movement feel same as when unpossesd
@export var upwards_movement_multiplyer: float = 2.5 # to compensate for gravity forcing you down
@export var downwards_movement_multiplyer: float = 0.5 

var dance_time: float = 0


func _ready() -> void:
	rigid_body = get_parent()


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	_dance(delta)
	_gravity_and_resistance(delta)


func possesed_movement(speed: float, acceleration: float, delta: float) -> void:
	var input: Vector2 = SimpleInput.get_vector()
	_draggable_movement(input, speed, acceleration, delta)


func _dance(delta) -> void:
	if is_possessed:
		dance_time += delta * dance_speed
		rigid_body.rotation_degrees = dance_amplitude * sin(dance_time)
	else:
		rigid_body.rotation_degrees = 0


func _gravity_and_resistance(delta: float) -> void:
	rigid_body.linear_velocity += Vector2(0, gravity_strength) * delta
	var current_velocity: Vector2 = get_parent().linear_velocity
	rigid_body.linear_velocity -= current_velocity * delta * delta * resistance


func _draggable_movement(input: Vector2, speed: float, acceleration: float, delta: float) -> void:
	if input.length() > 0:
		input = input.normalized()
	if input.y < 0:
		input.y *= upwards_movement_multiplyer
	else:
		input.y *= downwards_movement_multiplyer
	rigid_body.linear_velocity += input * speed * delta * speed_mult


func toggle_possessed() -> void:
	super.toggle_possessed()
