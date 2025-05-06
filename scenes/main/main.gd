extends Node2D

var lifetime = 0

func _physics_process(delta: float) -> void:
	lifetime += delta
	if lifetime > 1.0 and $bullets.get_node_or_null("bullet2") != null:
		$bullets/bullet2.movefunc = func(p0, p1, t): self.position.lerp(p0, t)
	return;
