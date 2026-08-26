extends Node3D

## My references
@export var input_get_away : String = "get_away"
@export var input_get_closer : String = "get_closer"

@export var hand_margin: float = 0.2
@export var hand_step: float = 0.01
var hand_initial_position: float = 0

var objects_at_reach: Array[Pickable]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_initial_position = self.position.z
	pass # Replace with function body.


func _process(delta: float) -> void:	
	if(Input.is_action_just_pressed("interact") && objects_at_reach.size() > 0):
		objects_at_reach[0]._pick(self)
	
	if(Input.is_action_just_released("interact") && objects_at_reach.size() > 0):
		objects_at_reach[0]._unpick()

func _unhandled_input(event: InputEvent) -> void:
		if Input.is_action_just_pressed(input_get_away) && !_is_too_far():
			self.position.z = self.position.z - hand_step
		
		if Input.is_action_just_pressed(input_get_closer) && !_is_too_close():
			self.position.z = self.position.z + hand_step

func _is_too_far():
	return self.position.z <= hand_initial_position - hand_margin

func _is_too_close():
	return self.position.z >= hand_initial_position + hand_margin

func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body.is_in_group("pickable")):
		objects_at_reach.append(body)
	
	_update_selected_object()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if(body.is_in_group("pickable")):
		objects_at_reach[objects_at_reach.find(body)]._unhighlight()
		objects_at_reach.erase(body)
	
	_update_selected_object()

func _update_selected_object():
	if(objects_at_reach.size() > 0):
		objects_at_reach[0]._highlight()
