extends Node

@onready var order_generator = $"../Order_Generator"

@onready var order_box = $"../OrderBox"

var current_order: Order

@onready var spawn_point = $"../SpawnPoint"

@onready var order_button: OrderButton = $"../OrderButton"

var current_scene: int = 0

var number_of_demanded_orders: int = 0

var number_of_current_orders: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start('placeholder')
	get_viewport().set_input_as_handled()

func _create_new_order():
	current_order = order_generator._create_order(3, 3)
	
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
	number_of_current_orders += 1
	_clean_old_order()
	if(number_of_current_orders < number_of_demanded_orders):
		_create_new_order()
	else:
		_on_orders_finished();


func _on_orders_finished():
	current_scene += 1
	_next_scene()

func _on_timeline_ended():
	current_scene += 1
	_next_scene()

func _next_scene():
	match current_scene:
		1:
			number_of_demanded_orders = 1
			number_of_current_orders = 0
			_create_new_order()
		2:
			Dialogic.start('2_keep_going')
			get_viewport().set_input_as_handled()
		3:
			number_of_demanded_orders = 1
			number_of_current_orders = 0
			_create_new_order()
