extends Button

func _pressed() -> void:
	get_tree().root.add_child(load("res://scenes/main/main.tscn").instantiate())
	get_parent().get_parent().queue_free()
