extends RigidBody3D
class_name Pickable

var is_pickable:bool=false
@export var masa:float
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("obejtos")
	pass # Replace with function body.
