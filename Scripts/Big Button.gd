extends StaticBody3D
class_name size_button

@export var max_size:float=4
@export var min_size:float=0.1
@export var size_speed:int=3
@export var agrandar:bool

var player: CharacterBody3D
var particles:GPUParticles3D

func _process(delta):
	if player==null: return
	if agrandar:
		particles = player.get_node("Max") as GPUParticles3D
		if player.scale.x>=max_size:
			particles.emitting=false
			return
		particles.emitting=true
		player.fuerza+=0.2
		player.scale.x+=delta*size_speed
		player.scale.y+=delta*size_speed
		player.scale.z+=delta*size_speed
	else:
		particles= player.get_node("Min") as GPUParticles3D
		if player.scale.x<=min_size:
			particles.emitting=false
			return
		particles.emitting=true
		player.fuerza-=0.2
		player.scale.x-=delta*size_speed
		player.scale.y-=delta*size_speed
		player.scale.z-=delta*size_speed
	pass

func _on_effect_area_body_entered(body):
	player=body
	pass # Replace with function body.


func _on_effect_area_body_exited(body):
	particles.emitting=false
	player=null
	pass # Replace with function body.
