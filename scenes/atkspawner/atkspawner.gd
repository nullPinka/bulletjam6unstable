extends Node2D

var steppedon = false
var max_health = 30
var boss_health = max_health

func movepos():
	var x = randi_range(0, 1920 - $atkicon.get_rect().size.x)
	var y = randi_range(0, 1080 - $atkicon.get_rect().size.y)
	global_position = Vector2(x, y)

func area_entered(area):
	if area.get_parent().name == "player":
		steppedon = true
		$atkicon.modulate = Color("ff00ff")

func area_exited(area):
	if area.get_parent().name == "player":
		steppedon = false
		$atkicon.modulate = Color("ffdf00")

func attack():
	boss_health -= 1
	movepos()
	$Timer.start()

func _ready():
	movepos()
	$atkarea.area_entered.connect(area_entered)
	$atkarea.area_exited.connect(area_exited)
	$Timer.timeout.connect(movepos)

func _physics_process(delta: float) -> void:
	$atkicon.modulate.r = ($Timer.wait_time - $Timer.time_left) / $Timer.wait_time
	$atkicon.modulate.g = $Timer.time_left / $Timer.wait_time
	
	if steppedon:
		if Input.is_action_just_pressed("ui_accept") and !get_parent().get_player().isDead:
			attack()
			if boss_health == 0:
				get_parent().get_parent().add_child(load("res://scenes/mainmenu/mainmenu.tscn").instantiate())
				get_parent().queue_free()
	
	queue_redraw()

func _draw():
	var abox_color : Color = Color("ff0000ff")
	abox_color.r = ($Timer.wait_time - $Timer.time_left) / $Timer.wait_time
	abox_color.g = $Timer.time_left / $Timer.wait_time
	draw_rect(Rect2(Vector2(0,0), Vector2(128, 128 * .4)), abox_color)
