class_name CollisionShape


static func generate_from_texture(texture: Texture2D) -> Array[PackedVector2Array]:
	if not texture:
		return []
	
	var bitmap: BitMap = BitMap.new()
	bitmap.create_from_image_alpha(texture.get_image())
	var polygons: Array[PackedVector2Array] = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()), 0.0)
	
	var offset: Vector2 = texture.get_size() * 0.5
	var centered_polygons: Array[PackedVector2Array] =  []
	
	for poligon in polygons:
		var cenreted_polygon: PackedVector2Array = PackedVector2Array()
		for point in poligon:
			cenreted_polygon.append(point - offset)
		centered_polygons.append(cenreted_polygon)
	
	return centered_polygons


static func apply_to_node(collisionObject: CollisionObject2D, polygons: Array[PackedVector2Array]) -> Array[CollisionPolygon2D]:
	for child in collisionObject.get_children():
		if child is CollisionPolygon2D:
			collisionObject.remove_child(child)
			child.free()
	
	var cols: Array[CollisionPolygon2D] = []
	
	for polygon in polygons:
		var col := CollisionPolygon2D.new()
		col.polygon = polygon
		collisionObject.add_child(col)
		if Engine.is_editor_hint():
			col.owner = collisionObject
	
	return cols
