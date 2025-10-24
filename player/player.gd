extends CharacterBody2D
@export var idle_texture: Texture2D
@export var up_texture: Texture2D
@export var down_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D

@export var speed: float = 200
@export var acceleration: float = 1000
@export var friction: float = 2200

var possessed_furniture: Furniture = null

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
		$Sprite2D.texture = idle_texture
	else:
		velocity = velocity.move_toward(input * speed, acceleration * delta)
		if input.x < 0:
			$Sprite2D.texture = left_texture
		elif input.x > 0:
			$Sprite2D.texture = right_texture
		elif input.y < 0:
			$Sprite2D.texture = up_texture
		else:
			$Sprite2D.texture = down_texture
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("possess"):
		if possessed_furniture:
			possessed_furniture.toggle_possessed()
			visible = true
		else:
			var potential_furniture = null
			var potential_distance = null
			for area in $Area2D.get_overlapping_areas():
				if area.is_in_group("Furniture"):
					if !potential_furniture:
						potential_furniture = area as Furniture
						potential_distance = global_position.distance_to(area.global_position)     
					else:
						var new_distance = global_position.distance_to(area.global_position)
						if new_distance < potential_distance:
							potential_furniture = area
							potential_distance = new_distance
			if potential_furniture:
				possessed_furniture = potential_furniture
				possessed_furniture.toggle_possessed()
				visible = false
