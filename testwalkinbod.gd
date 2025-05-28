extends CharacterBody2D

var target_pos = Vector2(645, 450)

func _ready():
	$NavigationAgent2D.path_desired_distance = 4.0
	$NavigationAgent2D.target_desired_distance = 4.0
	
	actor_setup.call_deferred()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		set_movement_target(event.global_position)

func actor_setup():
	await get_tree().physics_frame
	set_movement_target(target_pos)

func set_movement_target(movement_target : Vector2):
	$NavigationAgent2D.target_position = movement_target

func turn_head(from, to):
	if not from >= to:
		$fov.rotation.lerp(from, to, 0.1)

func _physics_process(delta: float) -> void:
	if $NavigationAgent2D.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = $NavigationAgent2D.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * 200.0
	turn_head($fov.rotation, velocity.normalized().angle())
	move_and_slide()
