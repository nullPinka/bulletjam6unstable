extends Node2D

var hasControl = true

func _ready():
	$Area2D.area_entered.connect(death)

func _physics_process(delta):
	if hasControl:
		if Input.is_key_pressed(KEY_A):
			global_position.x -= 3
		if Input.is_key_pressed(KEY_D):
			global_position.x += 3
		if Input.is_key_pressed(KEY_W):
			global_position.y -= 3
		if Input.is_key_pressed(KEY_S):
			global_position.y += 3


func death(area):
	hasControl = false
	$GPUParticles2D.emitting = true
	$Icon.visible = false
	return;
