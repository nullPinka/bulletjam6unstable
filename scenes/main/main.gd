extends Node2D

var lifetime = 0

func get_player():
	return $player

func get_boss():
	return $boss

func _physics_process(delta: float) -> void:
	#if lifetime % 5 == 0:
		#$bulletmanager.spawn_spear(Vector2(0,1), 200, Vector2(100,100), Rect2(Vector2(100, 100), Vector2(120, 120)))
		#$bulletmanager.spawn_bullet(Vector2(100,lifetime).direction_to($player.global_position), 500, Vector2(100,lifetime))
	lifetime += delta
	#lifetime = lifetime % 1000
