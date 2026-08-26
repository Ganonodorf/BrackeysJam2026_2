extends Node3D

class_name Order

@export var items: Array[Pickable]

func _append(pickable: Pickable):
	items.append(pickable)
