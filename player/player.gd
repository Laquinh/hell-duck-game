extends CharacterBody2D

@export var speed: float = 200
@export var acceleration: float = 1000
@export var friction: float = 2200
@export var dance_amplitude: float = 4
@export var dance_speed: float = 5

var possessed_furniture: Node2D = null
var dance_time: float = 0

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
	
	if possessed_furniture:
		possessed_furniture.position = position
		dance_time += delta * dance_speed
		possessed_furniture.rotation_degrees = dance_amplitude * sin(dance_time)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("possess"):
		if possessed_furniture:
			dance_time = 0
			possessed_furniture.rotation_degrees = 0
			possessed_furniture = null
			visible = true      
		else:
			var potential_furniture = null
			var potential_distance = null
			for area in $Area2D.get_overlapping_areas():
				if area.is_in_group("Furniture"):
					if !potential_furniture:
						potential_furniture = area
						potential_distance = global_position.distance_to(area.global_position)     
					else:
						var new_distance = global_position.distance_to(area.global_position)
						if new_distance < potential_distance:
							potential_furniture = area
							potential_distance = new_distance
			if potential_furniture:
				possessed_furniture = potential_furniture
				position = possessed_furniture.position
				visible = false
