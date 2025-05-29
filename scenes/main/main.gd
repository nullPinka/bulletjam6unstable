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
	if $player/Icon.visible:
		$timecount.text = "[font_size=40]" + str(floori(lifetime)) + "[/font_size]"
