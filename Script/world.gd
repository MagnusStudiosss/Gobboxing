extends Node3D

var BoldWords = false
@warning_ignore("unused_signal")
signal Win
@warning_ignore("unused_signal")
signal Loss
@warning_ignore("unused_signal")
signal Paused
@warning_ignore("unused_signal")
signal Go
@warning_ignore("unused_signal")
signal StartCountDown
signal HealthPackAdded

func _on_you_player_dead() -> void:
	emit_signal("Loss")
	$AudioStreamPlayer.playing = false
	get_tree().paused = true
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_enemy_enemy_dead() -> void:
	emit_signal("Win")
	$AudioStreamPlayer.playing = false


func _input(event: InputEvent) -> void:
#Capture Mouse
	if event.is_action_pressed("FreeMouse"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("Escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		var PauseMenu = load("res://scenes/pause_menu.tscn")
		var PauseMenuIns = PauseMenu.instantiate()
		add_child(PauseMenuIns)
		get_tree().paused = true



func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	emit_signal("StartCountDown")


func _on_ref_start() -> void:
	emit_signal("Go")
	$AudioStreamPlayer.playing = true


func _on_ref_countdown() -> void:
	$Ref/AnimationPlayer.play("new_animation")


func _on_you_punchpointoverload() -> void:
	var HealthPack = load("res://scenes/health_pack.tscn")
	var HealthPackIns = HealthPack.instantiate()
	add_child(HealthPackIns)
	emit_signal("HealthPackAdded")
	
