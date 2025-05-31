extends Node2D

var hasControl = true
var isDead = false

func _ready():
	$Area2D.area_entered.connect(death)

func _process(delta):
	var speed = Vector2.ZERO
	if hasControl:
		if Input.is_key_pressed(KEY_A):
			speed.x -= 3
		if Input.is_key_pressed(KEY_D):
			speed.x += 3
		if Input.is_key_pressed(KEY_W):
			speed.y -= 3
		if Input.is_key_pressed(KEY_S):
			speed.y += 3
		if Input.is_key_pressed(KEY_SHIFT):
			speed *= 2
	
	move(speed)

func move(speed):
	global_position += speed
	if global_position.x > 1920:
		global_position.x = 1920
	if global_position.y > 1080:
		global_position.y = 1080
	
	if global_position.x < 0:
		global_position.x = 0
	if global_position.y < 0:
		global_position.y = 0
	return;

func death(area):
	if area.name != "atkarea":
		hasControl = false
		isDead = true
		$GPUParticles2D.emitting = true
		# Need to defer set to prevent unexpected behavior
		$Area2D.set_deferred("monitoring", false)
		
		await get_tree().create_timer(2).timeout
		
		get_parent().get_parent().add_child(load("res://scenes/mainmenu/mainmenu.tscn").instantiate())
		get_parent().queue_free()

# Drawing player sprite

func _physics_process(delta: float) -> void:
	queue_redraw()

func _draw():
	if !isDead:
		draw_circle(Vector2(0,0), 10, Color("ff00ff"))
