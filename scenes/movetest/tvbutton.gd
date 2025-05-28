extends Button

@onready var npc = get_parent().get_node("CharacterBody2D")

func _pressed() -> void:
	npc.set_movement_target(Vector2(100, 140))
	
