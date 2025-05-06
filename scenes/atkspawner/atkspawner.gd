extends Node2D

var steppedon = false

func movepos():
	# TODO: Randomize x/y within screen borders
	var x = randi_range(0, 1100)
	var y = randi_range(0, 400)
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
	# TODO: Attack boss
	movepos()
	$Timer.start()
	return;

func _ready():
	movepos()
	$Area2D.area_entered.connect(area_entered)
	$Area2D.area_exited.connect(area_exited)
	$Timer.timeout.connect(movepos)

func _physics_process(delta: float) -> void:
	if steppedon:
		if Input.is_action_just_pressed("ui_accept"):
			attack()
