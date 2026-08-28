extends RigidBody3D

class_name OrderButton

signal pressed

@onready var outline_mesh = $CollisionShape3D2/MeshInstance3D/Outline

var button_enabled: bool = false

func _enable():
	button_enabled = true

func _disable():
	button_enabled = false

func _press():
	pressed.emit()

func _is_button_enabled() -> bool:
	return button_enabled

func _highlight() -> void:
	outline_mesh.visible = true

func _unhighlight() -> void:
	outline_mesh.visible = false
