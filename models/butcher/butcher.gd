extends Node3D

class_name butcher

var butchering: bool = false
var butchered: bool = false
var counter: float = 0

@onready var animation_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer3D

func _process(delta: float) -> void:
	if(butchering):
		counter += delta
		if(counter >= 1.16 && butchered == false):
			audio_player.play()
			butchered = true
		if(counter >= 3.625 && butchered == true):
			counter = 0
			butchered = false


func _start_butchering():
	animation_player.play("Butching")
	butchering = true

func _start_look():
	animation_player.play("Look")
	butchering = false
	butchered = false
	counter = 0
