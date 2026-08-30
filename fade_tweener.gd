extends CanvasLayer

class_name FadeTweener

@onready var fade: ColorRect = $Fade
@onready var label: Label = $Label

func _fade_out() -> void:
	var tween := create_tween()
	tween.tween_property(fade, "color:a", 1.0, 1).set_trans(Tween.TRANS_SINE)
	
	await tween.finished
	
	label.visible = true
