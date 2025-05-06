extends "bullet.gd"

var movefunc = func(p0, p1, t) : return p0.lerp(p1, t)
var endp = Vector2.ZERO
var movementangle = Vector2.ZERO
var speed = 1
var fading = false;
var moving = false;

func rng_fade():
	# TODO: Fading bullets
	randomize()
	var fadeout = randf()
	var time = randi() + randf()
	var freq = randi()
	return;

# TODO: Aaaaa I forgot to use movefunc
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if moving:
		# Movefunc movement
		# position = movefunc.call(position, Vector2(100,400), lifetime)
		# Constant Movement @ desired angle/speed
		position += (Vector2(1,1) * movementangle).normalized() * speed
