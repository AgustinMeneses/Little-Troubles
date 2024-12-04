extends RigidBody3D
class_name Pickable

@onready var pick = $Sprite3D
@onready var collision = $CollisionShape3D
@onready var anim = $AnimationPlayer

var player : CharacterBody3D
var player_marker:Marker3D
var is_big : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("objetos")
	set_process(false)
	$Max.emitting = false
	pass # Replace with function body.

func _process(_delta):
	#print(mass)
	if player_marker==null: return
	global_position=player_marker.global_position
	rotation = player.rotation
	pass

func _picked_up(marker:Marker3D):
	player_marker=marker
	player = marker.get_parent()
	collision.disabled=true
	set_process(true)
	pass

func dropped_off():
	collision.disabled=false
	player_marker=null
	player = null
	position.x+=2
	set_process(false)

func _size(size:String, player : CharacterBody3D):
	if size == "big" and not is_big:
		anim.play("normal_to_big")
		is_big = true
		player.can_move = false
		await anim.animation_finished
		player.can_move = true
