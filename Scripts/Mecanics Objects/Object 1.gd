extends RigidBody3D
class_name Pickable

@onready var pick = $Sprite3D
@onready var collision = $CollisionShape3D
@onready var anim = $AnimationPlayer

var player : Player
var player_marker:Marker3D
var is_big : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("objetos")
	set_process(false)
	$Max.emitting = false
	pass # Replace with function body.
func _process(_delta):
	if player_marker==null: return
	rotation = player.rotation
	if player.ray_cast.is_colliding():
		var player_marker_2 = player.get_node("PickUp Marker2")
		global_position = player_marker_2.global_position
		return
	global_position=player_marker.global_position
	pass
func _picked_up(marker:Marker3D, the_player):
	player_marker=marker
	player = the_player
	if player.stados == 0:
		player._text("NO SE PUEDE AGARRAR OBJETOS MIENTRAS SOS CHIQUITO")
		return
	collision.disabled=true
	set_process(true)
	pass
func dropped_off(): 
	collision.disabled=false
	player_marker=null
	player = null
	position.x+=2
	position.y -=3
	set_process(false)
func _size(size:String, player : CharacterBody3D):
	if size == "big" and not is_big:
		anim.play("normal_to_big")
		is_big = true
		player.can_move = false
		await anim.animation_finished
		player.can_move = true
