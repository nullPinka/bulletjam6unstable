extends Node2D

var bullets = []
var spears = []
var max_lifetime : float = 12.0
var bounding_box = Rect2(Vector2.ZERO, Vector2(1920, 1080))

# Creating bullets

func spawn_bullet(mov : Vector2, speed: float, spawn_point : Vector2) -> void:
	var bullet : Bullet = Bullet.new()
	bullet.movement_vector = mov
	bullet.speed = speed
	bullet.spawn_point = spawn_point
	bullet.current_position = spawn_point
	
	_configure_bullet_collision(bullet)
	
	bullets.append(bullet)

func _configure_bullet_collision(bullet : Bullet) -> void:
	var used_transform = Transform2D(0, position)
	used_transform.origin = bullet.current_position
	
	var hitbox = PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(hitbox, 8)
	PhysicsServer2D.area_add_shape($shared_area.get_rid(), hitbox, used_transform)
	
	bullet.shape_rid = hitbox

# On my own: try spears

#func spawn_spear(mov : Vector2, speed : float, spawn_point : Vector2, points : Rect2) -> void:
	#var bullet : Spear = Spear.new()
	#bullet.movement_vector = mov
	#bullet.speed = speed
	#bullet.spawn_point = points.position
	#bullet.current_position = points.position
	#bullet.points = points
	#
##	_configure_spear_collision(bullet)
	#_configure_bullet_collision(bullet)
	#
	#spears.append(bullet)
#
#func _configure_spear_collision(bullet : Spear):
	#var used_transform = Transform2D(0, position)
	#used_transform.origin = bullet.current_position
	#
	#var hitbox = PhysicsServer2D.segment_shape_create()
	#PhysicsServer2D.shape_set_data(hitbox, bullet.points)
	#PhysicsServer2D.area_add_shape($shared_area.get_rid(), hitbox, used_transform)
	#
	#bullet.shape_rid = hitbox

# Moving bullets

func _physics_process(delta: float) -> void:
	var used_transform = Transform2D()
	var bullet_destruction_queue = []
	
	for i in range(0, bullets.size()):
		var bullet = bullets[i] as Bullet
		
		if bullet.lifetime > max_lifetime or !bounding_box.has_point(bullet.current_position):
			bullet_destruction_queue.append(bullet)
			continue
		
		var offset : Vector2 = bullet.movement_vector.normalized() * bullet.speed * delta
		
		bullet.current_position += offset
		used_transform.origin = bullet.current_position
		PhysicsServer2D.area_set_shape_transform($shared_area.get_rid(), i, used_transform)
		
		bullet.lifetime += delta
	
	#for i in range(0, spears.size()):
		#var bullet = spears[i] as Spear
		#
		#if bullet.lifetime > max_lifetime:
			#bullet_destruction_queue.append(bullet)
			#continue
		#
		#var offset : Vector2 = bullet.movement_vector.normalized() * bullet.speed * delta
		#
		#bullet.points.size += offset
		#bullet.points.position += offset
		#bullet.current_position += offset
		#
		#used_transform.origin = bullet.current_position
		#PhysicsServer2D.area_set_shape_transform($shared_area.get_rid(), i, used_transform)
		#
		#bullet.lifetime += delta
	
	for bullet in bullet_destruction_queue:
		PhysicsServer2D.free_rid(bullet.shape_rid)
		bullets.erase(bullet)

	queue_redraw()

# Drawing bullets
func _draw() -> void:
	for i in range(0, bullets.size()):
		var bullet = bullets[i]
		draw_circle(bullet.current_position, 8, Color8(255, 0, 0))
#	for i in range(0, spears.size()):
#		var bullet = spears[i]
#		draw_line(bullet.points.position, bullet.points.size, Color(0, 0, 255))
