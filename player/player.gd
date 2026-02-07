extends CharacterBody2D
@export var idle_texture: Texture2D
@export var up_texture: Texture2D
@export var down_texture: Texture2D
@export var left_texture: Texture2D
@export var right_texture: Texture2D

@export var speed: float = 200
@export var acceleration: float = 1000
@export var friction: float = 2200

var current_collider: CollisionShape2D = null
var original_collider_size: Vector2 = Vector2.ZERO
var possessed_furniture: FurnitureBehavior = null

func _ready():
	current_collider = $CollisionShape2D
	original_collider_size = current_collider.shape.size

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
			possessed_furniture = null
			visible = true
			collision_mask &= ~(1 << 0)
			current_collider.shape.size = original_collider_size
		else:
			var potential_furniture = null
			var potential_distance: float = INF
			print(1)
			for area in $Area2D.get_overlapping_areas():
				print(2)
				if area.is_in_group("Furniture"):
					print(3)
					if !potential_furniture:
						print(4)
						potential_furniture = area
						potential_distance = global_position.distance_to(area.global_position)
					else:
						print(5)
						var new_distance = global_position.distance_to(area.global_position)
						if new_distance < potential_distance:
							print(6)
							potential_furniture = area
							potential_distance = new_distance
			if potential_furniture:
				possessed_furniture = potential_furniture.behavior
				possessed_furniture.toggle_possessed()
				visible = false
				collision_mask |= 1 << 0
				var furniture: Furniture = potential_furniture.get("furniture")
				if furniture:
					if potential_furniture.furniture and potential_furniture.furniture.texture:
						current_collider.shape.size = potential_furniture.furniture.texture.get_size()
