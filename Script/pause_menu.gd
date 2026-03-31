extends Control



func _on_start_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
	get_tree().paused = false


func _on_quit_button_down() -> void:
	get_tree().quit()
