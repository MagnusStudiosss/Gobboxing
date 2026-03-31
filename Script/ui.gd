extends Control


func _ready() -> void:
	var World = get_tree().get_first_node_in_group("World")
	var Ref = get_tree().get_first_node_in_group("Ref")
	var Enemy = get_tree().get_first_node_in_group("Enemy")
	Ref.connect("Sig3",$".".on_ref_3)
	Ref.connect("Sig2",$".".on_ref_2)
	Ref.connect("Sig1",$".".on_ref_1)
	Ref.connect("Start",$".".on_ref_start)
	Enemy.connect("Shoot",$".".on_shot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
		$Health.set("value", $"../..".Health)
		$EmyHealth.set("value", $"../../..".get_child(0).Health)


func _on_you_lponch() -> void:
	$CanvasLayer/ArmSpriteL.play("ponch")
	$CanvasLayer/ArmSpriteL.position.y = 0
	await get_tree().create_timer(0.3).timeout
	$CanvasLayer/ArmSpriteL.play("default")
	$PUNCHPOINTS.set("value",$"../..".PUNCHPOINTS)


func _on_you_rponch() -> void:
	$CanvasLayer/ArmSpriteR.play("ponch")
	$CanvasLayer/ArmSpriteR.position.y = 0
	await get_tree().create_timer(0.3).timeout
	$CanvasLayer/ArmSpriteR.play("default")


func _on_you_player_dead() -> void:
	var LossScreen = load("res://scenes/loss_screen.tscn")
	var LossScreenIns = LossScreen.instantiate()
	add_child(LossScreenIns)


func on_ref_3():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("3")


func on_ref_2():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("2")


func on_ref_1():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play("1")


func on_ref_start():
		$AnimatedSprite2D.visible = false


func on_shot():
	var TimerTime = get_tree().create_timer(0.1)
	await TimerTime.timeout
	$ColorRect2.visible = true
	TimerTime = get_tree().create_timer(1)
	await TimerTime.timeout
	get_tree().quit()
