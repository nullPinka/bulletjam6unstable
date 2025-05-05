extends "bullet.gd"

var movefunc = func(p0, p1, t) : return p0.lerp(p1, t)
var endp = Vector2.ZERO
var anglefromboss = Vector2.ZERO

func rng_fade():
	randomize()
	var time = randf()
	var period = randi() + randf()
	return;

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	position += Vector2(1,1).normalized() * anglefromboss
