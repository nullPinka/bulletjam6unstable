extends "bullet.gd"

func movefunc(p0, p1, p2, t):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	
	return q0.lerp(q1, t)


func _physics_process(delta: float) -> void:
	movefunc.callv(parameters)
