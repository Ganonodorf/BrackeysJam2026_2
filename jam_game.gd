extends Node

@onready var order_generator = $"../Order_Generator"

@onready var order_box = $"../OrderBox"

var current_order: Order

@onready var spawn_point = $"../SpawnPoint"

@onready var order_button: OrderButton = $"../OrderButton"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Dialogic.start('test-timeline')
	#get_viewport().set_input_as_handled()
	
	_create_new_order()

func _create_new_order():
	current_order = order_generator._create_order(1, 1)
	
	order_box._set_order(current_order)
	
	for child in current_order.get_children():
		child.position = spawn_point.position

func _clean_old_order():
	for child in current_order.get_children():
		child.queue_free()
	
	current_order.queue_free()
	current_order = null

func _on_order_box_order_fulfilled() -> void:
	order_button._enable()

func _on_order_box_order_unfulfilled() -> void:
	order_button._disable()
	order_button._unhighlight()

func _on_order_button_pressed() -> void:
	_clean_old_order()
	_create_new_order()
