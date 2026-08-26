extends Node3D

class_name OrderGenerator

var order_scene = preload("res://scripts/order.tscn")

@export var items_to_generate: Array[Pickable]

func _create_order(min: int, max: int) -> Order:
	var new_order: Order = order_scene.instantiate()
	add_child(new_order)
	
	var number_of_items = randi_range(min, max)
	
	for i in range(number_of_items):
		var new_item = _instantiate_new_item()
		new_order.add_child(new_item)
		new_order._append(new_item)
	
	return new_order

func _instantiate_new_item() -> Pickable:
	var item_number = randi_range(0, items_to_generate.size() - 1)
	var new_item = items_to_generate[item_number].duplicate()
	return new_item
