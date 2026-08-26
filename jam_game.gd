extends Node

var order_generator_scene = preload("res://scripts/order_generator.tscn")
var order_generator: OrderGenerator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Dialogic.start('test-timeline')
	#get_viewport().set_input_as_handled()
	order_generator = order_generator_scene.instantiate()
	add_child(order_generator)
	
	var new_order: Order = order_generator._create_order(3, 5)
	print(new_order._to_string())
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
