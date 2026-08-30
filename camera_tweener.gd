extends Node3D

@onready var player_camera: Camera3D = $"../ProtoController/Head/Camera3D"
@onready var butcher_camera_1: Camera3D = $"CameraButcher1"
@onready var butcher_camera_2: Camera3D = $"CameraButcher2"

var PositionTween: Tween
var ZoomFov: Tween

func _change_camera_1():
	_change_camera(butcher_camera_1)

func _change_camera_2():
	_change_camera(butcher_camera_2)
	
func _change_camera(desired_camera: Camera3D):
	if(PositionTween): PositionTween.kill()
	PositionTween = create_tween()
	var target_transform: Transform3D = desired_camera.global_transform
	PositionTween.tween_property(player_camera, "global_transform", target_transform, 0.5).set_trans(Tween.TRANS_SINE)
	
	if(ZoomFov): ZoomFov.kill()
	ZoomFov = create_tween()
	var target_fov: float = desired_camera.fov
	ZoomFov.tween_property(player_camera, "fov", target_fov, 0.5).set_trans(Tween.TRANS_SINE)
