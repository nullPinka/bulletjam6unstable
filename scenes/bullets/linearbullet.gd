extends "bullet.gd"

func _ready():
	parameters = []

func movefunc():
	return;

func _physics_process(delta: float) -> void:
	movefunc.call(parameters)
