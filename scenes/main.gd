extends Node





func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_logo_pressed() -> void:
	var Box = load("res://scenes/main_menu_box.tscn")
	$Node2D.add_child(Box.instantiate())


func _on_canvas_layer_child_entered_tree(node: Node) -> void:
	if node is RigidBody2D:
		node.position = Vector2(randf_range(0,1152),0)
		node.rotation = deg_to_rad(randf_range(0,360))
