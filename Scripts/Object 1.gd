extends RigidBody3D
class_name Pickable

@onready var pick = $Sprite3D
@onready var collision = $CollisionShape3D

var player_marker:Marker3D
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("objetos")
	set_process(false)
	pass # Replace with function body.

func _process(_delta):
	#print(mass)
	if player_marker==null: return
	global_position=player_marker.global_position
	pass

func _picked_up(marker:Marker3D):
	player_marker=marker
	collision.disabled=true
	set_process(true)
	pass

func dropped_off():
	collision.disabled=false
	player_marker=null
	position.x+=2
	set_process(false)
