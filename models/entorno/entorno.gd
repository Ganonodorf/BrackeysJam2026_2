extends Node3D

class_name entorno

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _open_door():
	animation_player.play("open")
