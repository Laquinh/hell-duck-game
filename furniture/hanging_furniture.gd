extends FurnitureBehavior


@export var swinging_speed_multiplier: float = 6
@export var resistance: float = 200
var original_position: Vector2 = Vector2.ZERO
var pivot_offset: float = 0;


func _ready() -> void:
	rigid_body = get_parent()
	rigid_body.lock_rotation = false
	rigid_body.freeze = false
	
	rigid_body.center_of_mass_mode = RigidBody2D.CENTER_OF_MASS_MODE_CUSTOM
	pivot_offset = -rigid_body.sprite.texture.get_size().y * 0.5
	rigid_body.center_of_mass = Vector2(0, pivot_offset)
	original_position = rigid_body.position
	rigid_body.mass *= 2


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	_apply_gravity_and_resistance(delta)
	_lock_position(delta)


func _apply_gravity_and_resistance(delta: float) -> void:
	rigid_body.angular_velocity -= (rigid_body.rotation_degrees / 45) * swinging_speed_multiplier * delta
	rigid_body.angular_velocity -= rigid_body.angular_velocity * delta * delta * resistance


func _lock_position(delta: float) -> void:
	var positon_offset: Vector2 = Vector2(
		sin(deg_to_rad(rigid_body.rotation_degrees)),
		cos(deg_to_rad(rigid_body.rotation_degrees))
	)
	positon_offset.y -= 1
	positon_offset.x *= -1
	positon_offset *= pivot_offset
	rigid_body.position = original_position - positon_offset


func possesed_movement(speed: float, acceleration: float, delta: float) -> void:
	var input: Vector2 = SimpleInput.get_vector()
	rigid_body.angular_velocity += -input.x * swinging_speed_multiplier * delta
