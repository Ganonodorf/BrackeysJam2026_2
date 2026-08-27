extends Area3D

@export var pickable_group: String = "pickable"

@onready var spawn_point = $"../SpawnPoint"

func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group(pickable_group)):
		body.position = spawn_point.position
