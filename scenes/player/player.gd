extends Node2D

var hasControl = true

func _ready():
	$Area2D.area_entered.connect(death)

func _physics_process(delta):
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
	
	move(speed)

func move(speed):
	global_position += speed
	return;

func death(area):
	if area.name == "hitbox":
		hasControl = false
		$GPUParticles2D.emitting = true
		$Icon.visible = false
		# Need to defer set to prevent unexpected behavior
		$Area2D.set_deferred("monitoring", false)
		$Area2D.set_deferred("monitorable", false)
