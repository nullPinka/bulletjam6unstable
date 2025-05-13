extends Node2D

@onready var bullet_manager = get_parent().get_node("bulletmanager")
var spawn_radius = 6
var spawn_circle = PI * pow(spawn_radius, 2)

func spawn_bullet(mov : Vector2, speed : float, spawn : Vector2):
	bullet_manager.spawn_bullet(mov, speed, spawn)
