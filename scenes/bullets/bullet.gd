extends Node2D

var lifetime = 0;
var parameters = []

func _ready():
	$VisibleOnScreenNotifier2D.screen_exited.connect(func(): queue_free())

func linearmov(p0, p1, t):
	return p0.lerp(p1, t)

func _physics_process(delta):
	lifetime += delta
