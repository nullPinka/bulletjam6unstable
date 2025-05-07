extends Node2D

var lifetime = 0

func get_player():
	return $player

func get_boss():
	return $boss

func _physics_process(delta: float) -> void:
	lifetime += delta
	return;
