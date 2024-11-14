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
		_size("Max",1)
	else:
		_size("Min",-1)
	pass

func _size(particle_tipe:String, value:int):
	if player_object==null:
		player_particles = player.get_node(particle_tipe) as GPUParticles3D
		player_particles.emitting=true
		if value>0:
			if player.scale.x>=max_size:
				player_particles.emitting=false
				return
		else:
			if player.scale.x<=min_size:
				player_particles.emitting=false
				return
		player.scale *= Vector3(1 + 0.016 * size_speed*value, 1 + 0.016 * size_speed*value, 1 + 0.016 * size_speed*value)
		player.fuerza+=0.2*value
	else:
		object_particles = player_object.get_node(particle_tipe) as GPUParticles3D
		object_particles.emitting=true
		if value>0:
			if player_object.scale.x>=max_size:
				object_particles.emitting=false
				return
		else:
			if player_object.scale.x<=min_size:
				object_particles.emitting=false
				return
		player_object.scale *= Vector3(1 + 0.016 * size_speed*value, 1 + 0.016 * size_speed*value, 1 + 0.016 * size_speed*value)
		player_object.mass+=0.2*value

func _on_effect_area_body_entered(_body):
	player=_body
	# Tiene un objeto en la mano?
	if player.is_picked_up:
		player_object=player.object.front()
	else:
		player_object=null
	pass # Replace with function body.
func _on_effect_area_body_exited(_body):
	player_particles.emitting=false
	player=null
	player_object=null
	pass # Replace with function body.
