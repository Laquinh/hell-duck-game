class_name Furniture
extends Resource

@export var texture: Texture2D
@export var interaction_box_padding: Vector2
@export var furniture_behavior: Script

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# resources via the inspector.
func _init(p_texture = null, p_interaction_box_padding = Vector2.ZERO, p_furniture_behavior = null):
	texture = p_texture
	interaction_box_padding = p_interaction_box_padding
	furniture_behavior = p_furniture_behavior
