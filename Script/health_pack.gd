extends Node3D

signal HealthPlus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var Rand = randf_range(-5,5)
	self.position = Vector3(Rand,0,Rand)
	$Sprite3D/AnimationPlayer.play("Spiiiiin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite3D.rotate_y(delta)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("You"):
		emit_signal("HealthPlus")
		$".".queue_free()
