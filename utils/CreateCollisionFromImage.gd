@tool
class_name CreateCollisionFromImage
extends CollisionObject2D

@export var texture: Texture2D

@export_tool_button("Generate Collision", "Callable") var generate_collision_action = generate_collision

func generate_collision() -> void:
	CollisionShape.apply_to_node(self, CollisionShape.generate_from_texture(texture))
