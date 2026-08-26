extends Node3D

class_name Order_box

@export var order: Order
var inside: Array[Pickable]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(_is_order_completed()):
		print("estoy completo")
	else:
		print("No estoy completo")

func _set_order(new_order: Order):
	order = new_order

func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body.is_in_group("pickable")):
		inside.append(body)

func _on_area_3d_body_exited(body: Node3D) -> void:
	if(body.is_in_group("pickable")):
		inside.erase(body)

func _is_order_completed() -> bool:
	return _inside_number_is_equal_to_order() && _inside_contains_same_elements_than_order()
	
func _inside_number_is_equal_to_order() -> bool:
	return order._size() == inside.size()

func _inside_contains_same_elements_than_order() -> bool:
	for pickable in inside:
		if(!order._has(pickable)): return false
		if(inside.count(pickable) != order._count(pickable)): return false
	return true
