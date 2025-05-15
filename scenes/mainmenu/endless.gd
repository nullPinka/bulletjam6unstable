extends Button

func _pressed() -> void:
	var main = load("res://scenes/main/main.tscn").instantiate()
	get_tree().root.add_child(main)
	main.get_node("atkspawner").boss_health = -1
	main.state = main.gs.ENDLESS
	get_parent().get_parent().queue_free()
