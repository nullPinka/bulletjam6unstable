extends Node2D

func _ready():
	$bullets/bullet.set_script("res://scenes/bullets/cubicbullet.gd")
	$bullets/bullet2.set_script("res://scenes/bullets/quadraticbullet.gd")
	$bullets/bullet3.set_script("res://scenes/bullets/linearbullet.gd")
	
	var newbull = load("res://scenes/bullets/bullet.tscn")
	newbull.set_script("res://scenes/bullets/cubicbullet.gd")
	$bullets.add_child(newbull)
