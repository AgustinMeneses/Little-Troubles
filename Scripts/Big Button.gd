extends StaticBody3D
class_name size_button

@export var max_size:float=4
@export var min_size:float=0.1
@export var size_speed:int=3
@export var agrandar:bool

var player:CharacterBody3D
var player_object:RigidBody3D
var particles:GPUParticles3D

func _process(delta):
	if player==null: return
	#agrandar o encojer?
	if agrandar:
		_size("Max",1,player_object)
	else:
		_size("Min",-1,player_object)
	pass

func _size(particle_tipe:String, value:int, object):
	particles = player.get_node(particle_tipe) as GPUParticles3D
	if value>0:
		if player.scale.x>=max_size:
			particles.emitting=false
			return
	else:
		if player.scale.x<=min_size:
			particles.emitting=false
			return
	particles.emitting=true
	if player_object==null:
		player.scale.x+=0.016*size_speed*value
		player.scale.y+=0.016*size_speed*value
		player.scale.z+=0.016*size_speed*value
		player.fuerza+=0.2*value
	else:
		player_object.scale.x+=0.016*size_speed*value
		player_object.scale.y+=0.016*size_speed*value
		player_object.scale.z+=0.016*size_speed*value
		player_object.mass+=0.2*value

func _on_effect_area_body_entered(body):
	player=body
	if player.is_picked_up:
		player_object=player.object
	else:
		player_object=null
	pass # Replace with function body.


func _on_effect_area_body_exited(body):
	particles.emitting=false
	player=null
	player_object=null
	pass # Replace with function body.
