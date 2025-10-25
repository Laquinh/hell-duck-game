class_name FurnitureBehavior
extends Area2D

var is_possessed: bool = false

func toggle_possessed() -> void:
	is_possessed = !is_possessed
