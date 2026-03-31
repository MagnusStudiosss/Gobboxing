extends RigidBody3D

var Enemy
var You


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Enemy = get_tree().get_first_node_in_group("Enemy")
	You = get_tree().get_first_node_in_group("You")
