extends Node2D

var lifetime = 0

func _physics_process(delta: float) -> void:
	lifetime += delta
	if lifetime > 1.0 and $bullets.get_node_or_null("bullet2") != null:
		$bullets/bullet2.parameters = [Vector2(400, 400), Vector2(50, 200), 0.0001]
	return;
