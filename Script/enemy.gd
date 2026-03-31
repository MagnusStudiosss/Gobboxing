extends CharacterBody3D

var BaseSpeed = 5
var Speed = BaseSpeed
var DMG = 15
var Health = 500
var Direction
var Coordinates
var BoldWords = false
@warning_ignore("unused_signal")
signal Hit
@warning_ignore("unused_signal")
signal EnemyDead
signal Stopped
@warning_ignore("unused_signal")
signal BoxTime
@warning_ignore("unused_signal")
signal Shoot
var Loser = false
var StoppedBool = false


func _ready() -> void:
	Speed = 0
	await get_parent_node_3d().Go
	Speed = BaseSpeed


func _physics_process(delta: float) -> void:
	var You = get_tree().get_first_node_in_group("You")
	Direction = Vector3(You.position - self.position).normalized() *delta * Speed
	var Collision = move_and_collide(Direction)
	if Collision:
		if Collision.get_collider() is CharacterBody3D:
			if Speed == BaseSpeed:
				if BoldWords == true:
					Speed = -6
					emit_signal("Hit")
		if Collision.get_collider() is StaticBody3D:
			if Loser == false:
				Speed = BaseSpeed

	if Speed < 0:
		Speed = Speed - Speed * (delta * 3)
	if Speed < 0 and Speed > -0.3:
		if Loser == false:
			Speed = BaseSpeed
		else:
			if StoppedBool == false:
				StoppedBool = true
				emit_signal("Stopped")


	BoldWords = You.BoldWords


func _input(event: InputEvent) -> void:
	var You = get_tree().get_first_node_in_group("You")
	if event.is_action_pressed("ponchL") or event.is_action_pressed("ponchR"):
		if Loser == false:
			if BoldWords == true:
				$AudioStreamPlayer3D.play()
				Health = Health - You.DMG
				Speed = -6
				if Health <= 0:
					Loser = true
					emit_signal("EnemyDead")
					await Stopped
					$Sprite3D.play("loser")
					emit_signal("BoxTime")

	BoldWords = You.BoldWords


func _on_hit() -> void:
	$Sprite3D.play("ponch")
	await get_tree().create_timer(0.5).timeout
	if Loser == false:
		$Sprite3D.play("default")


func _on_box_time() -> void:
	look_at(get_tree().get_first_node_in_group("You").position)
	var Box = load("res://scenes/box.tscn")
	var BoxIns = Box.instantiate()
	add_child(BoxIns)


func _on_ref_gun() -> void:
	$Sprite3D/Sprite3D3.visible = true
	var TimerTime = get_tree().create_timer(2)
	await TimerTime.timeout
	emit_signal("Shoot")
	$AudioStreamPlayer3D.stream = load("res://Audio/Sounds/Gunshot.mp3")
	$AudioStreamPlayer3D.play()
	
