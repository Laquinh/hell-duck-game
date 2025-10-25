class_name NpcBehavior
extends Area2D

func _physics_process(delta: float) -> void:
	for area in get_parent().get_overlapping_areas():
		if area.is_in_group("Furniture"):
			var npc_initialiser: NpcInitialiser = get_parent()
			if area in npc_initialiser.scary_furniture:
				npc_initialiser.scary_furniture.erase(area)
				if npc_initialiser.scary_furniture.size() > 0:
					print("AAAAAAAAAAAAHHH")
				else:
					print("I can't take this anymore")
