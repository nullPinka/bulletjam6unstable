extends Node2D

# Attacking
@onready var bullet_manager = get_parent().get_node("bulletmanager")
var spawn_radius = 100 # Spawn radius = 100 for polar coords
@onready var player = get_parent().get_player()
# Moving
var moving = false
var m_to_pos = Vector2.ZERO
var t_steps : float = 60
var c_steps : float = 0
var speed = 5
var attacking = false

signal stopped_moving
signal next_attack

# Attacking

func spawn_bullet(mov : Vector2, speed : float, spawn : Vector2):
	bullet_manager.spawn_bullet(mov, speed, spawn)

func player_chase(num : int, speed : int = 200):
	for i in range(0, num):
		# Polar coord to Cartesian -> send it
		var angle_to_player = get_angle_to(player.global_position)
		var loc = Vector2(spawn_radius * cos(angle_to_player), spawn_radius * sin(angle_to_player))
		spawn_bullet(loc, speed, loc + global_position)
		await get_tree().create_timer(.1).timeout

func player_cave(num : int, speed : float = 200, degree: float = PI/4):
	for i in range(0, num):
		# Place on polar coordinate from spawn_radius (relative to boss)
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
		

func sweep(from : float, to : float, num : int, speed : float = 200, delay : float = 0.1):
	for i in range(0, num):
		var angle = lerp(from, to, i/float(num - 1))
		var loc : Vector2 = Vector2(spawn_radius * cos(angle), spawn_radius * sin(angle))
		spawn_bullet(loc, speed, loc + global_position)
		
		# Without this if, there's a base initialization time that gets waited, preventing the desired effect
		if delay != 0:
			await get_tree().create_timer(delay).timeout

func attack(num : int = -1):
	attacking = true;
	
	if num == -1:
		randomize()
		num = randi_range(1, 7)
	
	match num:
		2:
			var bullc = randi() % 50
			player_cave(bullc, 200, deg_to_rad(randf_range(15, 90)))
			await player_chase(bullc, (randi() % 200) + 200)
		3:
			var start = deg_to_rad(randf_range(0, 360))
			var end = deg_to_rad(randf_range(start + 20, start + 340))
			var bullc = randi_range(0, 20)
			await sweep(start, end, bullc)
		4:
			var deg = randf_range(15, 90)
			await player_cave(5, 200, deg_to_rad(deg))
		5:
			var mov_vec = Vector2(randi_range(0, 200), randi_range(0, 200))
			await move(global_position + mov_vec)
		6:
			var mov_vec = Vector2(randi_range(0, 200), randi_range(0, 200))
			move(global_position + mov_vec)
		1:
			await sweep(0, 3600, randi_range(361, 719), 200, randf_range(0.001, 0.01))
		7:
			sweep(0, 3600, randi_range(361, 719), 200, randf_range(0.001, 0.1))
			
	emit_signal("next_attack")
	attacking = false

# Debugging

func _ready():
	await get_tree().create_timer(1).timeout


# Movement

func move(to_pos):
	if to_pos.x < 100 or to_pos.y < 100 or to_pos.x > 1920 or to_pos.y > 1080:
		return;
	
	moving = true
	m_to_pos = to_pos

func _process(delta: float) -> void:
	if !attacking:
		attack()

func _physics_process(delta: float) -> void:
	if moving:
		if moving:
			# Could involve calc to make it move Not Particularly Linearly. Do later
			global_position = global_position.move_toward(m_to_pos, speed)
			if global_position == m_to_pos:
				moving = false
				emit_signal("stopped_moving")
	
	queue_redraw()

func _draw():
	var tlc_pos = 128 * 1.2 / 2 * -1
	draw_rect(Rect2(Vector2(tlc_pos,tlc_pos), Vector2(128 * 1.2, 128 * 1.2)), Color("00bbff"))
	
