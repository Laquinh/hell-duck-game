extends FurnitureBehavior

var player: CharacterBody2D = null

@export var dance_amplitude: float = 4
@export var dance_speed: float = 5

var dance_time: float = 0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	if is_possessed:
		get_parent().position = player.position
		dance_time += delta * dance_speed
		get_parent().rotation_degrees = dance_amplitude * sin(dance_time)
	else:
		get_parent().rotation_degrees = 0
