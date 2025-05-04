extends Node2D

var lifetime = 0;
var movefunc = null
var parameters = null

func _ready():
	$VisibleOnScreenNotifier2D.screen_exited.connect(func(): queue_free())


func linearmov(p0, p1, t):
	return p0.lerp(p1, t)

func _physics_process(delta):
	lifetime += delta
	# movefunc = cubicbezier
	# parameters = [position, (position + Vector2(5, 0)).rotated(rotation), (position + Vector2(0, 7)).rotated(rotation), (position + Vector2(10, 10)).rotated(rotation), 0.001]
	# movefunc = linearmov
	# parameters = [position, position - Vector2(0, -100), 0.1]
	if movefunc != null:
		position = movefunc.callv(parameters.call())
