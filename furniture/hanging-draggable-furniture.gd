extends DraggableFurniture


var stuck_to_wall: bool = true
var time_under_stress: float = 0


func _ready() -> void:
	rigid_body = get_parent()
	rigid_body.freeze = true


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if stuck_to_wall:
		return
	_dance(delta)
	_gravity_and_resistance(delta)


func possesed_movement(speed: float, acceleration: float, delta: float):
	var input: Vector2 = SimpleInput.get_vector()	
	if stuck_to_wall:
		_hanging_movement(input, delta)
		return
	_draggable_movement(input, speed, acceleration, delta)


func _hanging_movement(input: Vector2, delta: float) -> void:
	if input != Vector2.ZERO:
		time_under_stress += delta
		dance_time += delta * dance_speed * time_under_stress * 4
		rigid_body.rotation_degrees = dance_amplitude * sin(dance_time)
		if time_under_stress >= 2:
			stuck_to_wall = false
			rigid_body.freeze = false
	else:
		rigid_body.rotation_degrees = dance_amplitude * sin(dance_time)
		time_under_stress = 0
	return


func toggle_possessed() -> void:
	super.toggle_possessed()
