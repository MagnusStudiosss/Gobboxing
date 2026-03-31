extends CharacterBody3D


var Health = 100
const DMG = 15
var SPEED = 5.0
var PUNCHPOINTS = 0
const JUMP_VELOCITY = 4.5
const MouseSensitivity  = 0.008
@warning_ignore("unused_signal")
signal Lponch
@warning_ignore("unused_signal")
signal Rponch
@warning_ignore("unused_signal")
signal PlayerDead
signal PUNCHPOINTOVERLOAD
var MouseCap = false
var BoldWords = false
var JustHit = false
var LastUsedLeft


#camera rotation
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	SPEED = 0

#Track Punch Input
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ponchL"):
		emit_signal("Lponch")
		if LastUsedLeft == false:
			PUNCHPOINTS = PUNCHPOINTS + 5
		LastUsedLeft = true
		if PUNCHPOINTS == 100:
			PUNCHPOINTS = 0
			emit_signal("PUNCHPOINTOVERLOAD")
	if event.is_action_pressed("ponchR"):
		emit_signal("Rponch")
		if LastUsedLeft == true:
			PUNCHPOINTS = PUNCHPOINTS + 5
		LastUsedLeft = false
		if PUNCHPOINTS == 100:
			emit_signal("PUNCHPOINTOVERLOAD")
			PUNCHPOINTS = 0

#Rotate Camera With Mouse
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_y(-event.relative.x  * MouseSensitivity)
		$Camera3D.rotate_x(-event.relative.y * MouseSensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x,-0.9,0.7)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("WalkLeft", "WalkRight", "WalkForward", "WalkBackward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		BoldWords = true

	
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		BoldWords = false


func _on_enemy_hit() -> void:
	if JustHit == false:
		Health = Health - $"../Enemy".DMG
		$AudioStreamPlayer3D.play()
		if Health <= 0:
			emit_signal("PlayerDead")
		JustHit = true
		var JustHitTimer = get_tree().create_timer(0.5)
		await JustHitTimer.timeout
		JustHit = false


func _on_world_go() -> void:
	SPEED = 5.0


func on_health_plus():
	Health = Health + 20


func _on_world_health_pack_added() -> void:
	var HealthPack = get_tree().get_first_node_in_group("Health")
	HealthPack.connect("HealthPlus",on_health_plus)
