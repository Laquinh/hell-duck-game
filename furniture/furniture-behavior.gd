@abstract class_name FurnitureBehavior
extends Node2D


var rigid_body: FurnitureInitialiser = null


var is_possessed: bool = false:
	set(value):
		if is_possessed == value:
			return
		is_possessed = value
		if is_possessed:
			_on_possession_start()
		else:
			_on_possession_end()


func toggle_possessed() -> void:
	is_possessed = !is_possessed


@abstract
func possesed_movement(speed: float, acceleration: float, delta: float) -> void


func _on_possession_start() -> void:
	pass


func _on_possession_end() -> void:
	pass
