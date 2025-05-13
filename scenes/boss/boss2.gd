extends Node2D

@onready var bullet_manager = get_parent().get_node("bulletmanager")
var spawn_radius = 100 # Spawn radius = 100 for polar coords
var spawn_circle = PI * pow(6, 2) # Spawn radius = 6
@onready var player = get_parent().get_player()

func spawn_bullet(mov : Vector2, speed : float, spawn : Vector2):
	bullet_manager.spawn_bullet(mov, speed, spawn)

func player_chase(num):
	for i in range(0, num):
		# Polar coord to Cartesian -> send it
		var angle_to_player = get_angle_to(player.global_position)
		var loc = Vector2(spawn_radius * cos(angle_to_player), spawn_radius * sin(angle_to_player))
		spawn_bullet(loc, 200, loc + global_position)
		await get_tree().create_timer(.1).timeout

func player_cave(num : int, speed : float = 200, degree: float = PI/4):
	for i in range(0, num):
		# Place on polar coordinate from spawn_radius
		# x = r * cos(theta)
		# y = r * sin(theta)
		# r = radius of circle/length of line
		# theta = angle to point from default Vector2.RIGHT in RADIANS
		
		var angle_to_player = get_angle_to(player.global_position)
		var cave_degree : float = degree
		var angle_from_player : float = cave_degree / 2.0
		
		# Polar coordinates to spawn at
		var bull1 : Vector2 = Vector2(spawn_radius * cos((angle_to_player - angle_from_player)), spawn_radius * sin(angle_to_player - angle_from_player))
		var bull2 : Vector2 = Vector2(spawn_radius * cos((angle_to_player + angle_from_player)), spawn_radius * sin(angle_to_player + angle_from_player))
		var bull3 : Vector2 = Vector2(spawn_radius * cos(angle_to_player), spawn_radius * sin(angle_to_player))
		
		spawn_bullet(bull1, speed, bull1 + global_position)
		spawn_bullet(bull2, speed, bull2 + global_position)
		spawn_bullet(bull3, speed, bull3 + global_position)
		
		await get_tree().create_timer(.1).timeout
		

func sweep(from : float, to : float, num : int):
	for i in range(0, num):
		var angle = lerp(from, to, i/float(num - 1))
		var loc : Vector2 = Vector2(spawn_radius * cos(angle), spawn_radius * sin(angle))
		spawn_bullet(loc, 200, loc + global_position)
		await get_tree().create_timer(.1).timeout

func _ready():
	await get_tree().create_timer(1).timeout
	for i in range(0, 12):
		sweep(PI/4, 3 * PI/4, 8)
		await get_tree().create_timer(.3).timeout
