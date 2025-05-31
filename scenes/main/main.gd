extends Node2D

var lifetime = 0
enum gs {ENDLESS, BOSS}
var state = gs.BOSS

func get_player():
	return $player

func get_boss():
	return $boss

func _physics_process(delta: float) -> void:
	lifetime += delta
	if state == gs.ENDLESS:
		$timecount.text = "[center][font_size=40]" + str(($atkspawner.boss_health + 1) * -1) + "[/font_size][/center]"
	elif !$player.isDead:
		$timecount.text = "[center][font_size=40]" + str(floori(lifetime)) + "[/font_size][/center]"
