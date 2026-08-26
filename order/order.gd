extends Node3D

class_name Order

@export var items: Array[Pickable]

func _append(pickable: Pickable):
	items.append(pickable)

func _size() -> int:
	return items.size()

func _has(pickable: Pickable) -> bool:
	return items.has(pickable)

func _count(pickable: Pickable) -> int:
	return items.count(pickable)

func _to_string() -> String:
	var return_string: String = "Order: "
	for item in items:
		return_string = return_string + item.to_string() + " "
	
	return return_string
