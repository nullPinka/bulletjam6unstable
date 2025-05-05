extends "bullet.gd"

func _enter_tree():
	parameters = [position, position + Vector2(100, 20), position + Vector2(1000, 200), position + Vector2(10,5), 0.001]

func movefunc(p0, p1, p2, p3, t):
	var q0 = p0.lerp(p1, t)
	var q1 = p1.lerp(p2, t)
	var q2 = p2.lerp(p3, t)
	
	var r0 = q0.lerp(q1, t)
	var r1 = q1.lerp(q2, t)
	
	return r0.lerp(r1, t)

func _physics_process(delta: float) -> void:
	position = movefunc.callv([position, position + Vector2(100, 20), position + Vector2(50, 300), position + Vector2(500,10), 0.01])
