extends Node3D

## My references
@onready var raycast: RayCast3D = $RayCast3D

@export var input_get_away : String = "get_away"
@export var input_get_closer : String = "get_closer"

@export var hand_margin: float = 0.2
@export var hand_step: float = 0.01
var hand_initial_position: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_initial_position = self.position.z
	pass # Replace with function body.


func _process(delta: float) -> void:
	var object = raycast.get_collider()
	
	if(raycast.is_colliding() && object.is_in_group("pickable")):
		object._higlight()
	
	if(raycast.is_colliding() && object.is_in_group("pickable") && Input.is_action_just_pressed("interact")):
		object._pick(self)
	
	if(raycast.is_colliding() && object.is_in_group("pickable") && Input.is_action_just_released("interact")):
		object._unpick()

func _unhandled_input(event: InputEvent) -> void:
		if Input.is_action_just_pressed(input_get_away) && !_is_too_far():
			self.position.z = self.position.z - hand_step
		
		if Input.is_action_just_pressed(input_get_closer) && !_is_too_close():
			self.position.z = self.position.z + hand_step

func _is_too_far():
	return self.position.z <= hand_initial_position - hand_margin

func _is_too_close():
	return self.position.z >= hand_initial_position + hand_margin
