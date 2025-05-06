extends Node2D

var r = 6
var spawncirc = PI * r * r
var lifetime = 0

# Spawn bullets in the spawning area surrounding the boss

func circumatt(from, to, gap, bullet : String, speed = 1):
	var newbull = load("res://scenes/bullets/" + bullet + ".tscn")
	for i in range(from, to, gap):
		var tempbull = newbull.instantiate()
		tempbull.scale = Vector2(0.5,0.5)
		tempbull.position = spawncirc * Vector2.from_angle(i * (PI / 180))
		tempbull.movementangle = Vector2.from_angle(i * (PI / 180))
		tempbull.speed = speed
		tempbull.moving = true
		add_child(tempbull)
	return;

func shotgun(bullet):
	circumatt(0, 180, 8, "linearbullet")
	circumatt(5, 185, 7, "linearbullet", 3)
	circumatt(-5, 175, 6, "linearbullet", 6)

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
	
	return;

func _ready():
	await get_tree().create_timer(5).timeout
	var linear = load("res://scenes/bullets/linearbullet.tscn")
	linespawn(Vector2(100, 100), Vector2(100, 600), Vector2(1,0), 10, linear)
	shotgun(1)

#func _physics_process(delta: float) -> void:
#	lifetime += delta
#	if lifetime > 3:
#		shotgun("l")
#		lifetime = 0
