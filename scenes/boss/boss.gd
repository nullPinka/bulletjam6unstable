extends Node2D

var r = 6
var spawncirc = PI * r * r

func circumatt(from, to, gap, bullet : String, speed = 1):
	var newbull = load("res://scenes/bullets/" + bullet + ".tscn")
	for i in range(from, to, gap):
		var tempbull = newbull.instantiate()
		tempbull.scale = Vector2(0.5,0.5)
		tempbull.position = spawncirc * Vector2.from_angle(i * (PI / 180))
		tempbull.anglefromboss = Vector2.from_angle(i * (PI / 180))
		tempbull.speed = speed
		add_child(tempbull)
	return;

func _ready():
	circumatt(0, 180, 8, "linearbullet")
	circumatt(5, 185, 7, "linearbullet", 3)
	circumatt(-5, 175, 6, "linearbullet", 6)
