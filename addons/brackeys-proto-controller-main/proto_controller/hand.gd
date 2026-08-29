extends Node3D

## My references
@export var input_get_away : String = "get_away"
@export var input_get_closer : String = "get_closer"

@export var hand_close_margin: float = 0.4
@export var hand_far_margin: float = 0.6
@export var hand_step: float = 0.01

@onready var raycast: RayCast3D = $RayCast3D

var hand_initial_position: float = 0

var objects_at_reach: Array[Pickable]

var object_picked: Pickable

var object_highlighted: Pickable

var button_highlighted: OrderButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_initial_position = self.position.z
	pass # Replace with function body.


func _process(delta: float) -> void:
	if(raycast.is_colliding() &&
	raycast.get_collider().is_in_group("pickable") &&
	raycast.get_collider() != object_highlighted):
		if(object_highlighted != null): object_highlighted._unhighlight()
		object_highlighted = raycast.get_collider()
		object_highlighted._highlight()
	
	if(raycast.is_colliding() &&
	raycast.get_collider().is_in_group("pickable") &&
	Input.is_action_just_pressed("interact")):
		object_picked = raycast.get_collider()
		object_picked._pick(self)
	
	if(object_picked != null &&
	Input.is_action_just_released("interact")):
		object_picked._unpick()
		object_picked == null
	
	if(raycast.is_colliding() &&
	raycast.get_collider().is_in_group("button") &&
	raycast.get_collider() != button_highlighted):
		if(button_highlighted != null): button_highlighted._unhighlight()
		button_highlighted = raycast.get_collider()
		button_highlighted._highlight()
	
	if(raycast.is_colliding() &&
	raycast.get_collider().is_in_group("button") &&
	Input.is_action_just_pressed("interact")):
		raycast.get_collider()._press()
	
	if(!raycast.is_colliding() ||
	(raycast.is_colliding() &&
	!raycast.get_collider().is_in_group("button") &&
	!raycast.get_collider().is_in_group("pickable"))):
		if(button_highlighted != null):
			button_highlighted._unhighlight()
			button_highlighted = null
		if(object_highlighted != null):
			object_highlighted._unhighlight()
			object_highlighted = null

#func _unhandled_input(event: InputEvent) -> void:
		#if Input.is_action_just_pressed(input_get_away) && !_is_too_far():
			#self.position.z = self.position.z - hand_step
		#
		#if Input.is_action_just_pressed(input_get_closer) && !_is_too_close():
			#self.position.z = self.position.z + hand_step

#func _is_too_far():
	#return self.position.z <= hand_initial_position - hand_far_margin
#
#func _is_too_close():
	#return self.position.z >= hand_initial_position + hand_close_margin
	#
#
#func _update_selected_object():
	#if(objects_at_reach.size() > 0):
		#objects_at_reach[0]._highlight()
