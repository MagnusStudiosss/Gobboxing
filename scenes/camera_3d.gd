extends Camera3D

const MouseSensitivity  = 0.008

#camera rotation
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	
	#Rotate Camera With Mouse
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_y(-event.relative.x  * MouseSensitivity)
		$Camera3D.rotate_x(-event.relative.y * MouseSensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x,-0.9,0.7)
