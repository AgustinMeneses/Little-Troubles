extends StaticBody3D
class_name size_button

@onready var anim = $AnimationPlayer

@export var max_size:float=4
@export var min_size:float=0.1
@export var size_speed:int=3
@export var agrandar:bool

var player: CharacterBody3D

func _process(delta):
	if agrandar:
		if player==null or player.scale.x>=max_size: return
		player.fuerza+=0.2
		player.scale.x+=delta*size_speed
		player.scale.y+=delta*size_speed
		player.scale.z+=delta*size_speed
	else:
		if player==null or player.scale.x<=min_size: return
		player.fuerza-=0.2
		player.scale.x-=delta*size_speed
		player.scale.y-=delta*size_speed
		player.scale.z-=delta*size_speed
	print_debug(player.fuerza)
	pass

func _on_effect_area_body_entered(body):
	player=body
	pass # Replace with function body.


func _on_effect_area_body_exited(body):
	player=null
	pass # Replace with function body.
