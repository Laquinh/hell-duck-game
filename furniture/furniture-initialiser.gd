@tool # marking this script as tool and will make it run in editor as well
class_name FurnitureInitialiser
extends RigidBody2D

@export var furniture: Furniture:
	set(value): # by definig a setter we can run the _ready() when it's changed in the editor
		furniture = value
		if Engine.is_editor_hint():
			_ready()
			
@onready var sprite: Sprite2D = $Area2D/Sprite2D
@onready var interaction_box: CollisionShape2D = $Area2D/CollisionShape2D
var behavior: FurnitureBehavior = null

@export_tool_button("Refresh", "Callable") var generate_collision_action = _ready
func _ready():
	if furniture:
		if furniture.texture:
			interaction_box.shape.size = furniture.texture.get_size() + furniture.interaction_box_padding
			mass = furniture.texture.get_size().length() * 5
		sprite.texture = furniture.texture
		if furniture.furniture_behavior:
			behavior = furniture.furniture_behavior.new()
			add_child(behavior)
			var is_editor = Engine.is_editor_hint()
			behavior.set_process(!is_editor)
			behavior.set_physics_process(!is_editor)
	CollisionShape.apply_to_node(self, CollisionShape.generate_from_texture(sprite.texture))
