extends RigidBody3D

class_name Pickable

var is_picked: bool = false
var rotation_bias: Vector3 = Vector3.ZERO

@onready var outline_good_mesh = $model/MeshGood/Outline
@onready var outline_bad_mesh = $model/MeshBad/Outline
@onready var good_mesh = $model/MeshGood
@onready var bad_mesh = $model/MeshBad

@onready var current_outline = outline_good_mesh
@onready var current_mesh = good_mesh

@export var pickable_group: String = "pickable"

@export var rotation_up : String = "vertical_rotation_up"
@export var rotation_down : String = "vertical_rotation_down"
@export var rotation_right : String = "horizontal_rotation_right"
@export var rotation_left : String = "horizontal_rotation_left"

@export var vertical_rotation_speed : Vector3 = Vector3(0, 0, 0.1)
@export var horizontal_rotation_speed : Vector3 = Vector3(0, 0.1, 0)

@export var fragility : float = 1.5

var original_parent: Node3D

var is_broken: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	original_parent = get_parent()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_picked):
		if(Input.is_action_pressed(rotation_right)):
			global_rotate(Vector3.UP, 0.1)
		
		if(Input.is_action_pressed(rotation_left)):
			global_rotate(Vector3.UP, -0.1)
		
		if(Input.is_action_pressed(rotation_up)):
			global_rotate(get_parent().global_transform.basis.x, -0.1)
		
		if(Input.is_action_pressed(rotation_down)):
			global_rotate(get_parent().global_transform.basis.x, 0.1)

func _pick(new_picador: Node3D) -> void:
	reparent(new_picador)
	freeze = true
	is_picked = true

func _unpick() -> void:
	reparent(original_parent)
	freeze = false
	is_picked = false

func _highlight() -> void:
	current_outline.visible = true

func _unhighlight() -> void:
	current_outline.visible = false

func _on_body_entered(body: Node) -> void:
	if(body.is_in_group(pickable_group) &&
	!is_broken &&
	!is_broken && body.mass > mass
	&& body.linear_velocity.length() > fragility):
	#body.linear_velocity.length() > linear_velocity.length() &&
	#body.mass + body.mass * body.linear_velocity.length() > mass + 1):
		#print("Soy ", name, " con ", body.name, " y sale: ", body.mass + body.mass * body.linear_velocity.length())
		_break()

func _break():
	is_broken = true
	current_outline = outline_bad_mesh
	good_mesh.visible = false
	bad_mesh.visible = true

func _is_broken():
	return is_broken
