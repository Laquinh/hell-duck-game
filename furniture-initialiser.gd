@tool # marking this script as tool and will make it run in editor as well
extends Area2D

@export var furniture: Furniture:
	set(value): # by definig a setter we can run the _ready() when it's changed in the editor
		furniture = value
		_ready()

@onready var sprite: Sprite2D = $Sprite2D
@onready var interaction_box: CollisionShape2D = $CollisionShape2D

func _ready():
	if furniture:
		interaction_box.shape.size = furniture.texture.get_size() + furniture.interaction_box_padding
		sprite.texture = furniture.texture
