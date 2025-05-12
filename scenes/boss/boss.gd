extends Node2D

var r = 6
var spawncirc = PI * r * r
var lifetime = 0
var moving = false
var moving_to = Vector2.ZERO

signal attack_done

# Spawn bullets in spawn circle around boss
func circumatt(from, to, gap, bullet : String, speed = 1, num = 1):
	if gap == 0:
		gap = 1
	
	# set to = -1 if being used for a single bullet
	if to == -1:
		to = from + 1
	
	var newbull = load("res://scenes/bullets/" + bullet + ".tscn")
	for j in range(0, num):
		for i in range(from, to, gap):
			var tempbull = newbull.instantiate()
			tempbull.scale = Vector2(0.5,0.5)
			tempbull.global_position = spawncirc * Vector2.from_angle(i * (PI / 180)) + global_position
			tempbull.movementangle = Vector2.from_angle(i * (PI / 180))
			tempbull.speed = speed
			tempbull.moving = true
			get_parent().add_child(tempbull)
		await get_tree().create_timer(.2).timeout

func shotgun(bullet):
	circumatt(0, 180, 8, bullet)
	circumatt(5, 185, 7, bullet, 3)
	circumatt(-5, 175, 6, bullet, 6)

func linespawn(from, to, dir, num, bullet, spawn_delay = .1):
	var curr = from
	var i = 1.0
	var bullarr = []
	
	# Build line for bullets to follow
	var linelen = from.distance_to(to)
	
	while curr != to:
		# Build bullet object
		var newbull = bullet.instantiate()
		newbull.position = curr
		newbull.movementangle = dir
		newbull.speed = 5
		
		get_parent().add_child(newbull)
		
		# Update current position on line
		curr = from.lerp(to, i/num)
		i += 1
		bullarr.append(newbull)
		
		await get_tree().create_timer(spawn_delay).timeout
	
	# Move all bullets at once
	for bull in bullarr:
		bull.moving = true

func cone_follow(degree, num, bullet, speed):
	var player = get_parent().get_player()
	for i in range(0, num):
		var degplayang = get_angle_to(player.global_position) * (180/PI)
		circumatt(degplayang + degree/2, -1, 0, "linearbullet", speed)
		circumatt(degplayang, -1, 0, "linearbullet", speed)
		circumatt(degplayang - degree/2, -1, 0, "linearbullet", speed)
		await get_tree().create_timer(.3).timeout

func follow_shot(num, bullet):
	var player = get_parent().get_player()
	for i in range(0, num):
		circumatt(get_angle_to(player.global_position) * (180/PI), -1, 0, "linearbullet")
		await get_tree().create_timer(.3).timeout

func move(to):
	moving_to = to
	moving = true

func attack(setattk = -1):
	var select
	if setattk == -1:
		randomize()
		select = randi_range(0, 5)
	else:
		select = setattk
	match select:
		1:
			var fullang = 45
			var degplayang = get_angle_to(get_parent().get_player().global_position) * (180/PI)
			circumatt(degplayang + (fullang/2), degplayang + 360 - fullang/2, 2, "linearbullet", 3, 100)
			return;
		2:
			return;

func _ready():
	await get_tree().create_timer(1).timeout
	attack_done.connect(func(): 
		get_tree().create_timer(1).timeout
		attack()
		)
	#attack(1)
	await get_tree().create_timer(1).timeout
	var fullang = 45
	var degplayang = get_angle_to(get_parent().get_player().global_position) * (180/PI)
	circumatt(degplayang + (fullang/2), degplayang + 360 - fullang/2, 2, "linearbullet", 3, 100)
	
	await get_tree().create_timer(5).timeout
	
	var linear = load("res://scenes/bullets/linearbullet.tscn")
	#linespawn(Vector2(100, 100), Vector2(100, 600), Vector2(1,0), 10, linear)
	#shotgun(1)
	#follow_shot(100, linear)
	circumatt(0, 340, 2, "linearbullet", 3)
	cone_follow(20, 10, 1, 5)
	shotgun("linearbullet")
	move(Vector2(100,100))

func _physics_process(delta: float) -> void:
	if moving:
		global_position = global_position.lerp(moving_to, 0.01)
		if global_position == Vector2(100,100):
			moving = false
