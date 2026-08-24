extends RigidBody3D

var is_picked: bool = false
var rotation_bias: Vector3 = Vector3.ZERO

@export var rotation_up : String = "vertical_rotation_up"
@export var rotation_down : String = "vertical_rotation_down"
@export var rotation_right : String = "horizontal_rotation_right"
@export var rotation_left : String = "horizontal_rotation_left"

@export var vertical_rotation_speed : Vector3 = Vector3(0, 0, 0.1)
@export var horizontal_rotation_speed : Vector3 = Vector3(0, 0.1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_picked):
		if(Input.is_action_pressed(rotation_right)):
			global_rotate(Vector3.UP, 0.1)
		
		if(Input.is_action_pressed(rotation_left)):
			global_rotate(Vector3.UP, -0.1)
		
		if(Input.is_action_pressed(rotation_up)):
			global_rotate(Vector3.RIGHT, -0.1)
		
		if(Input.is_action_pressed(rotation_down)):
			global_rotate(Vector3.RIGHT, 0.1)

func _pick(new_picador: Node3D) -> void:
	reparent(new_picador)
	freeze = true
	is_picked = true
	

func _unpick() -> void:
	reparent(get_tree().root)
	freeze = false
	is_picked = false

#func _put_horizontal() -> void:
	#var xAngle: float  = Vector3.UP.angle_to(transform.basis.x)
	#var yAngle: float  = Vector3.UP.angle_to(transform.basis.y)
	#var zAngle: float  = Vector3.UP.angle_to(transform.basis.z)
	#var minusxAngle: float  = Vector3.UP.angle_to(-transform.basis.x)
	#var minusyAngle: float  = Vector3.UP.angle_to(-transform.basis.y)
	#var minuszAngle: float  = Vector3.UP.angle_to(-transform.basis.z)
	#
	#if(xAngle <= PI/4 || xAngle >= (3 * PI)/4):
		#var xAngleVector: Vector3 = Vector3(xAngle, 0, 0)
		#global_rotation += xAngleVector
	#
	#print("xAngle: ", xAngle)
	#print("yAngle: ", yAngle)
	#print("zAngle: ", zAngle)
	#print("-xAngle: ", minusxAngle)
	#print("-yAngle: ", minusyAngle)
	#print("-zAngle: ", minuszAngle)
