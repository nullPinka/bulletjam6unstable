extends Node2D

var lifetime = 0;

func _ready():
	$VisibleOnScreenNotifier2D.screen_exited.connect(func(): queue_free())

func _physics_process(delta):
	lifetime += delta
