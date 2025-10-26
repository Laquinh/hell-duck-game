@tool # marking this script as tool and will make it run in editor as well
class_name NpcInitialiser
extends Area2D

@export var npc: Npc:
	set(value): # by definig a setter we can run the _ready() when it's changed in the editor
		npc = value
@export var scary_furniture: Array[FurnitureInitialiser] = []

@onready var sprite: Sprite2D = $Sprite2D
@onready var interaction_box: CollisionShape2D = $CollisionShape2D
var behavior: NpcBehavior = null

func _ready():
	if npc:
		interaction_box.shape.size = npc.texture.get_size() + npc.interaction_box_padding
		sprite.texture = npc.texture
		behavior = npc.npc_behavior.new()
		add_child(behavior)
		
		var is_editor = Engine.is_editor_hint()
		behavior.set_process(!is_editor)
		behavior.set_physics_process(!is_editor)
