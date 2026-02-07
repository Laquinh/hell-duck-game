@tool
class_name CreateCollisionFromImage
extends CollisionObject2D

@export var texture: Texture2D

@export_tool_button("Generate Collision", "Callable") var generate_collision_action = generate_collision

func generate_collision() -> void:
	for child in get_children():
		if child is CollisionPolygon2D:
			remove_child(child)
			child.free()

	if not texture:
		return

	var bitmap: BitMap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_image())
	var polygons: Array[PackedVector2Array] = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()))
	
	var offset: Vector2 = texture.get_size() * 0.5

	for poligon in polygons:
		var cenreted_polygon: PackedVector2Array = PackedVector2Array()
		for point in poligon:
			cenreted_polygon.append(point - offset)

		var col := CollisionPolygon2D.new()
		col.polygon = cenreted_polygon
		add_child(col)
		if Engine.is_editor_hint():
			col.owner = get_tree().edited_scene_root
