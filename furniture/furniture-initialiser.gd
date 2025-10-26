@tool # marking this script as tool and will make it run in editor as well
class_name FurnitureInitialiser
extends Area2D

@export var furniture: Furniture:
	set(value): # by definig a setter we can run the _ready() when it's changed in the editor
		furniture = value
		if Engine.is_editor_hint():
			_ready()

@onready var sprite: Sprite2D = $Sprite2D
@onready var interaction_box: CollisionShape2D = $CollisionShape2D
var behavior: FurnitureBehavior = null

func _ready():
	if furniture:
		if furniture.texture:
			interaction_box.shape.size = furniture.texture.get_size() + furniture.interaction_box_padding
		sprite.texture = furniture.texture
		if furniture.furniture_behavior:
			behavior = furniture.furniture_behavior.new()
			add_child(behavior)
		
			var is_editor = Engine.is_editor_hint()
			behavior.set_process(!is_editor)
			behavior.set_physics_process(!is_editor)
