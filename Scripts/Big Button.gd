extends StaticBody3D
class_name size_button

@export var max_size:float=4
@export var min_size:float=0.1
@export var size_speed:int=3
@export var agrandar:bool

var player:CharacterBody3D
var player_object:RigidBody3D
var player_particles:GPUParticles3D
var object_particles:GPUParticles3D

func _process(delta):
	if player==null: return
	if not player.is_picked_up:
		player_object=null
	#agrandar o encojer?
	if agrandar:
		_max()
	else:
		_min()
	pass

func _max():
	if player_object==null:
		player._size("normal")
	else:
		player_object._size("small")

func _min():
	if player_object==null:
		player._size("small")
	else:
		player_object._size("small")
func _on_effect_area_body_entered(_body):
	player=_body
	# Tiene un objeto en la mano?
	if player.is_picked_up:
		player_object=player.object.front()
	else:
		player_object=null
	pass # Replace with function body.

func _on_effect_area_body_exited(_body):
	player=null
	player_object=null
	pass # Replace with function body.
