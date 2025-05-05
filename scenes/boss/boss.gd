extends Node2D

var r = 6
var spawncirc = PI * r * r

func _ready():
	var newbull = load("res://scenes/bullets/linearbullet.tscn")
	for i in range(0, 359, 4):
		var tempbull = newbull.instantiate()
		tempbull.scale = Vector2(0.5,0.5)
		tempbull.position = spawncirc * Vector2.from_angle(i * (PI / 180))
		tempbull.anglefromboss = Vector2.from_angle(i * (PI / 180))
		add_child(tempbull)
