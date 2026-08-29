extends Node

@onready var order_generator = $"../Order_Generator"

@onready var order_box = $"../OrderBox"

var current_order: Order

@onready var spawn_point = $"../SpawnPoint"

@onready var order_finished_button: OrderButton = $"../OrderButton"
@onready var new_order_button: OrderButton = $"../OrderButtonNewOrder"

@onready var controller = $"../ProtoController"

var current_scene: int = 0

var number_of_demanded_orders: int = 0

var number_of_current_orders: int = 0

var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	order_finished_button._disable()
	new_order_button._disable()
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start('placeholder')
	get_viewport().set_input_as_handled()

func _create_new_order():
	current_order = order_generator._create_order(5, 5)
	
	order_box._set_order(current_order)
	
	for child in current_order.get_children():
		child.global_position = spawn_point.position

func _clean_old_order():
	for child in current_order.get_children():
		child.queue_free()
	
	current_order.queue_free()
	current_order = null

func _on_order_box_order_fulfilled() -> void:
	#order_finished_button._enable()
	pass

func _on_order_box_order_unfulfilled() -> void:
	#order_finished_button._disable()
	#order_finished_button._unhighlight()
	pass

func _on_order_button_pressed() -> void:
	order_finished_button._disable()
	
	number_of_current_orders += 1
	
	_calculate_score()
	
	_clean_old_order()
	
	if(number_of_current_orders < number_of_demanded_orders):
		new_order_button._enable()
	else:
		_on_orders_finished();

func _on_order_button_new_order_pressed() -> void:
	order_finished_button._enable()
	new_order_button._disable()
	_create_new_order()

func _on_orders_finished():
	current_scene += 1
	_next_scene()

func _on_timeline_ended():
	current_scene += 1
	_next_scene()

func _calculate_score():
	var price: int = order_box._give_me_the_price()
	
	score += price
	
	controller._update_score(str(score))

func _next_scene():
	match current_scene:
		1:
			number_of_demanded_orders = 2
			number_of_current_orders = 0
			new_order_button._enable()
		2:
			Dialogic.start('2_keep_going')
			get_viewport().set_input_as_handled()
		3:
			number_of_demanded_orders = 3
			number_of_current_orders = 0
			new_order_button._enable()
