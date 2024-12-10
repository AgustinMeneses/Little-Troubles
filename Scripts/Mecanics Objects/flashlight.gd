extends StaticBody3D
@onready var pick = $MeshInstance3D/Sprite3D
var player_marker : Marker3D
var player : CharacterBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("flashlight")
	set_process(false)
	$MeshInstance3D/SpotLight3D.light_energy = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = player_marker.global_position
	rotation = player.rotation
	pass

func _picked_up(marker:Marker3D):
	player_marker=marker
	player = marker.get_parent()
	set_process(true)
	pick.queue_free()
	$CollisionShape3D.queue_free()
	$MeshInstance3D/SpotLight3D.light_energy = 16
	$AnimationPlayer.stop()
	pass

func _change_colors(size):
	if size == "smol":
		$AnimationPlayer.play("normal_to_small")
	else:
		$AnimationPlayer.play("small_to_norma")
